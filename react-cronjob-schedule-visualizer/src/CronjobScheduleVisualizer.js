import { useState } from 'react';
import dayjs from 'dayjs';
import dayjsPluginUTC from 'dayjs-plugin-utc'
import Box from '@mui/material/Box';
import Paper from '@mui/material/Paper';
import Stack from '@mui/material/Stack';
import TextareaAutosize from '@mui/material/TextareaAutosize';

import CronjobSchedule from './CronjobSchedule';
import Header from './Header';

dayjs.extend(dayjsPluginUTC);

const placeholder = `

# run the cron process every hour of every day
0 * * * * /usr/bin/wget -O - -q -t 1 http://localhost/cron.php

# generate links to new blog posts twice a day
5 10,22 * * * /var/www/bin/mk-new-links.php

# run the backup scripts at 4:30am
30 4 * * * /var/www/bin/create-all-backups.sh

# re-generate the blog "categories" list (four times a day)
5 0,4,10,16 * * * /var/www/bin/create-cat-list.sh

# reset the contact form just after midnight
5 0 * * * /var/www/bin/resetContactForm.sh

# rotate the ad banners every five minutes
0,20,40  * * * * /var/www/bin/ads/freshMint.sh
5,25,45  * * * * /var/www/bin/ads/greenTaffy.sh
10,30,50 * * * * /var/www/bin/ads/raspberry.sh
15,35,55 * * * * /var/www/bin/ads/robinsEgg.sh
`;

export default function CronjobScheduleVisualizer() {
  const [cronjobs, setCronjobs] = useState([]);
  const [date, setDate] = useState(dayjs());

  const handleCronjobChange = (e) => {
    setCronjobs(e.target.value.split("\n").filter(Boolean));
  };

  const handleDateChange = (newDate) => {
    setDate(newDate);
  };

  return (
    <>
      <Header date={date} handleDateChange={handleDateChange} />
      <Box>
        <Stack spacing={2}>
          <Paper
            elevation={8}
            square
            style={{
              paddingBottom: 8,
              paddingLeft: 24,
              paddingTop: 16,
            }}>
            <TextareaAutosize
              maxRows={30}
              placeholder={placeholder}
              style={{
                border: 'none',
                boxShadow: 'none',
                outline: 'none',
                overflow: 'auto',
                resize: 'none',
                width: '100%',
              }}
              onChange={handleCronjobChange}
            />
          </Paper>
          <CronjobSchedule cronjobs={cronjobs} date={date} />
        </Stack>
      </Box>
    </>
  );
}
