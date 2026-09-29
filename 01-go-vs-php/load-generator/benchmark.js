import http from 'k6/http';
import { check, sleep } from 'k6';

// Read scenario from environment (smoke, stress, spike)
const scenarioType = __ENV.TEST_SCENARIO || 'stress';

let stages = [];
if (scenarioType === 'smoke') {
  // Quick 10s smoke test with 20 virtual users
  stages = [
    { duration: '3s', target: 20 },
    { duration: '7s', target: 20 },
    { duration: '2s', target: 0 },
  ];
} else if (scenarioType === 'spike') {
  // Sudden burst spike test
  stages = [
    { duration: '2s', target: 10 },
    { duration: '5s', target: 400 },
    { duration: '5s', target: 400 },
    { duration: '3s', target: 0 },
  ];
} else {
  // Default: Video reel stress & breaking test (ramp up from 10 -> 100 -> 300 -> 500 users)
  stages = [
    { duration: '5s', target: 20 },   // Warm up
    { duration: '10s', target: 100 }, // Moderate load
    { duration: '15s', target: 250 }, // Heavy load
    { duration: '15s', target: 400 }, // Saturation point
    { duration: '10s', target: 500 }, // Breaking point test
    { duration: '5s', target: 0 },   // Cool down
  ];
}

export const options = {
  stages: stages,
  thresholds: {
    // Collect stats without failing run on 5xx to observe breaking point
    'http_req_duration{service:service-a}': ['p(95)>=0'],
    'http_req_duration{service:service-b}': ['p(95)>=0'],
  },
};

const serviceAUrl = __ENV.SERVICE_A_URL || 'http://service-a:8080/bench';
const serviceBUrl = __ENV.SERVICE_B_URL || 'http://service-b:8080/bench';

export default function () {
  const paramsA = {
    tags: { service: 'service-a' },
    timeout: '5s',
  };

  const paramsB = {
    tags: { service: 'service-b' },
    timeout: '5s',
  };

  // Dispatch requests to both services simultaneously
  const resA = http.get(serviceAUrl, paramsA);
  const resB = http.get(serviceBUrl, paramsB);

  check(resA, {
    'Service A status is 200': (r) => r.status === 200,
  });

  check(resB, {
    'Service B status is 200': (r) => r.status === 200,
  });

  // Tiny sleep between iterations for smooth rate generation
  sleep(0.05);
}
