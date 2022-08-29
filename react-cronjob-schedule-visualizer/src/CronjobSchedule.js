import Box from '@mui/material/Box';

import Cronjob from './Cronjob.class';
import { buildCronjobSchedule, getMinutesForYear, isSameDay } from './Cronjob.utils';

export default function CronjobSchedule(props) {
  const cronjobs = props.cronjobs.map(cronjob => new Cronjob(cronjob));
  const selectedDate = new Date(props.date.toISOString());
  const minutes = getMinutesForYear(props.date.year()).filter(date => isSameDay(date, selectedDate));
  const cronjobSchedule = buildCronjobSchedule(cronjobs, minutes);

  return (
    <Box px={3}>
      <pre style={{
        fontSize: 13.333,
      }}>
        {cronjobSchedule.join("\n")}
      </pre>
    </Box>
  );
}
