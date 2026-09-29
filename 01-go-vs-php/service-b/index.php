<?php
header('Content-Type: application/json');

// Simulate realistic in-memory computation and JSON serialization matching Go
$items = [];
for ($i = 0; $i < 50; $i++) {
    $items[] = $i * $i;
}

$response = [
    'service' => 'PHP 8.4',
    'timestamp' => date('c'),
    'message' => 'Benchmarked successfully',
    'items' => $items,
];

echo json_encode($response);
