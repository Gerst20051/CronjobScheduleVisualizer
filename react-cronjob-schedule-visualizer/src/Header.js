import AppBar from '@mui/material/AppBar';
import Box from '@mui/material/Box';
import Toolbar from '@mui/material/Toolbar';
import Typography from '@mui/material/Typography';

import DatePicker from './DatePicker';

export default function Header({ date, handleDateChange }) {
  return (
    <Box sx={{ flexGrow: 1 }}>
      <AppBar position="static">
        <Toolbar>
          <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
            Cronjob Schedule Visualizer
          </Typography>
          <Box sx={{ py: 3 }}>
            <DatePicker date={date} handleDateChange={handleDateChange} />
          </Box>
        </Toolbar>
      </AppBar>
    </Box>
  );
}
