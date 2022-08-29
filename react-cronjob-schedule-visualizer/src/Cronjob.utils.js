function getStartOfYearDate(year = new Date().getFullYear()) {
  return new Date(year, 0, 1);
}

function getEndOfYearDate(year = new Date().getFullYear()) {
  const date = new Date(year + 1, 0, 1);
  date.setMinutes(date.getMinutes() - 1);
  return date;
}

function addMinutesToDate(numOfMinutes, date) {
  const dateCopy = new Date(date.getTime());
  dateCopy.setMinutes(dateCopy.getMinutes() + numOfMinutes);
  return dateCopy;
}

function getMinutesBetweenDates(startDate, endDate, interval = 1) {
  const minutesOfTheYear = [];
  while (startDate < endDate) {
    startDate = addMinutesToDate(interval, startDate);
    minutesOfTheYear.push(startDate);
  }
  return minutesOfTheYear;
}

export function getMinutesForYear(year = new Date().getFullYear()) {
  const startOfYearDate = getStartOfYearDate(year);
  const endOfYearDate = getEndOfYearDate(year);
  return getMinutesBetweenDates(startOfYearDate, endOfYearDate);
}

export function isSameDay(date1, date2) {
  return !!(
    date1.getDate() === date2.getDate() &&
    date1.getMonth() === date2.getMonth() &&
    date1.getFullYear() === date2.getFullYear()
  );
}

export function buildCronjobSchedule(jobs, minutes) {
  return jobs.reduce((results, job) => {
    results.push(...job.minuteMatches(minutes).map(
      minute => `${minute.getTime()} ${minute.toISOString()} (${job.cronjob})`
    ));
    return results;
  }, []).sort().map(job => job.split(' ').slice(1).join(' '));
}
