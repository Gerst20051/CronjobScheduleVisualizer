import {
  Bar,
  BarChart,
  Brush,
  Label,
  ResponsiveContainer,
  Tooltip,
  XAxis,
  YAxis,
} from 'recharts';

function generateDataArray() {
  return Array(1440).fill(null).map((_, i) => ({
    minute: i,
  }));
}

function randomPastelColor() {
  const r = (Math.round(Math.random() * 127) + 127).toString(16);
  const g = (Math.round(Math.random() * 127) + 127).toString(16);
  const b = (Math.round(Math.random() * 127) + 127).toString(16);
  return '#' + r + g + b;
}

const baseData = generateDataArray();

function generateChartData(cronjobBarChartData, cronjobKeys) {
  const data = [...baseData];
  for (let i = 0, il = cronjobKeys.length; i < il; i++) {
    for (let j = 0, jl = cronjobBarChartData[cronjobKeys[i]].length; j < jl; j++) {
      data[cronjobBarChartData[cronjobKeys[i]][j]][cronjobKeys[i]] = 1;
    }
  }
  return data;
}

export default function CronjobScheduleBarChart({ cronjobBarChartData }) {
  const cronjobKeys = Object.keys(cronjobBarChartData);

  if (!cronjobKeys.length) return;

  return (
    <ResponsiveContainer width="100%" height={400}>
      <BarChart data={generateChartData(cronjobBarChartData, cronjobKeys)} margin={{ left: 30, right: 50, top: 20 }}>
        <XAxis dataKey="minute" height={80}>
          <Label value="minutes from midnight utc" offset={25} position="insideBottom" />
        </XAxis>
        <YAxis label={{ value: 'number of cronjobs', angle: -90, dy: -60, position: 'insideBottomLeft' }} />
        <Tooltip />
        <Brush dataKey="minute" height={30} stroke={randomPastelColor()} />
        {cronjobKeys.map(key => <Bar key={key} dataKey={key} stackId="a" fill={randomPastelColor()} />)}
      </BarChart>
    </ResponsiveContainer>
  );
}
