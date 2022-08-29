export default class Cronjob {
  constructor(cronjob) {
    const parts = cronjob.split(' ');
    this.cronjob = cronjob;
    this.minute = parts[0]; // 0-59
    this.hour = parts[1]; // 0-23
    this.monthday = parts[2]; // 1-31
    this.month = parts[3]; // 1-12, JAN-DEC
    this.weekday = parts[4]; // 0-6, SUN-SAT
    this.command = parts[5]; // TODO: combine the remaining parts
  }

  matches(timestamp) {
    return !!(
      this.matchesWeekday(timestamp) &&
      this.matchesMonth(timestamp) &&
      this.matchesMonthday(timestamp) &&
      this.matchesHour(timestamp) &&
      this.matchesMinute(timestamp)
    );
  }

  matchLogic(value, input) {
    // TODO: Handle JAN-DEC and SUN-SAT
    if (value === '*') return true;
    if (value.includes('*/')) {
      const nthValue = value.split('/')[1];
      if (input % nthValue === 0) return true;
    }
    if (value.includes('-')) {
      const range = value.split('-');
      const start = range[0];
      const end = range[1];
      if (input >= start && input <= end) return true;
    }
    if (value.includes(',')) {
      const values = value.split(',').map(Number);
      if (values.includes(input)) return true;
    }
    if (+value === input) return true;
    return false;
  }

  matchesWeekday(timestamp) {
    return this.matchLogic(this.weekday, timestamp.getDay());
  }

  matchesMonth(timestamp) {
    return this.matchLogic(this.month, timestamp.getHours());
  }

  matchesMonthday(timestamp) {
    return this.matchLogic(this.monthday, timestamp.getDate());
  }

  matchesHour(timestamp) {
    return this.matchLogic(this.hour, timestamp.getHours());
  }

  matchesMinute(timestamp) {
    return this.matchLogic(this.minute, timestamp.getMinutes());
  }

  minuteMatches(timestamps) {
    return timestamps.filter(timestamp => this.matches(timestamp));
  }
}
