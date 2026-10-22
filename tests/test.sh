#!/bin/bash
set -e
# tests/test.sh

PROG="./findmax"

if [ ! -x "$PROG" ]; then
    echo "Error: $PROG not found or not executable (run 'make' first)"
    exit 1
fi

pass=0
total=0

run_test() {
    local name="$1"
    local input="$2"
    local expected="$3"
    total=$((total + 1))
    local output
    output=$(echo -e "$input" | "$PROG")
    if [[ "$output" == *"$expected"* ]]; then
        echo "$name passed"
        pass=$((pass + 1))
    else
        echo "$name failed"
        echo "  expected substring: $expected"
        echo "  got: $output"
        exit 1
    fi
}

run_test "Test 1 (normal)"      "5\n1 5 3 9 2"   "Max value: 9"
run_test "Test 2 (single)"      "1\n42"          "Max value: 42"
run_test "Test 3 (negatives)"   "3\n-5 -1 -10"   "Max value: -1"

total=$((total + 1))
if echo -e "0" | "$PROG" >/dev/null 2>&1; then
    echo "Test 4 (empty) failed: expected non-zero exit"
    exit 1
else
    echo "Test 4 (empty) passed"
    pass=$((pass + 1))
fi

echo "All tests passed ($pass/$total)"
exit 0
