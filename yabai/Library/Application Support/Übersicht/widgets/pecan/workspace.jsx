const command = "bash pecan/scripts/ws";
const refreshFrequency = 1000; // ms

const render = ({ output }) => <div class='screen'><div class='segment pecanworkspace'>{`${output}`}</div></div>;

export { command, refreshFrequency, render };
