import Box from '@mui/material/Box';

export default function CronjobSchedule({ cronjobSchedule }) {
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
