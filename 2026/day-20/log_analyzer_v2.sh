# Task 7 – Generate Sample Logs Automatically

## Objective

Create a Bash script that generates a sample log file containing random log levels and messages.

This is useful for testing the `log_analyzer.sh` script without manually creating hundreds of log entries.

---

## Create `log_generator.sh`

```bash
#!/bin/bash

# Usage:
# ./log_generator.sh <log_file_path> <num_lines>

# Check arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <log_file_path> <num_lines>"
    exit 1
fi

log_file_path="$1"
num_lines="$2"

# Check whether the file already exists
if [ -e "$log_file_path" ]; then
    echo "Error: File already exists at $log_file_path."
    exit 1
fi

# Possible log levels
log_levels=("INFO" "DEBUG" "ERROR" "WARNING" "CRITICAL")

# Possible error messages
error_messages=(
    "Failed to connect"
    "Disk full"
    "Segmentation fault"
    "Invalid input"
    "Out of memory"
)

# Function to generate a random log line
generate_log_line() {

    local log_level="${log_levels[$((RANDOM % ${#log_levels[@]}))]}"
    local error_msg=""

    if [ "$log_level" == "ERROR" ]; then
        error_msg="${error_messages[$((RANDOM % ${#error_messages[@]}))]}"
    fi

    echo "$(date '+%Y-%m-%d %H:%M:%S') [$log_level] $error_msg - $RANDOM"
}

# Create the log file
touch "$log_file_path"

# Generate random log lines
for ((i=0; i<num_lines; i++)); do
    generate_log_line >> "$log_file_path"
done

echo "Log file created at: $log_file_path with $num_lines lines."
```

---

# Make the Script Executable

```bash
chmod +x log_generator.sh
```

---

# Run the Script

For example:

```bash
./log_generator.sh sample_log.log 100
```

Expected output:

```text
Log file created at: sample_log.log with 100 lines.
```

---

# Check the Generated Log

```bash
ls -lh sample_log.log
```

View the first 10 lines:

```bash
head sample_log.log
```

Example:

```text
2026-09-04 04:20:01 [INFO]  - 15234
2026-09-04 04:20:01 [ERROR] Failed to connect - 28761
2026-09-04 04:20:02 [WARNING]  - 31245
2026-09-04 04:20:02 [ERROR] Disk full - 10983
2026-09-04 04:20:03 [DEBUG]  - 24561
2026-09-04 04:20:03 [CRITICAL]  - 19873
```

---

# 🧠 Understanding the Script

## 1. `$#`

```bash
if [ "$#" -ne 2 ]; then
```

`$#` represents the **number of arguments** passed to the script.

The script requires exactly two:

```text
$1 → log file path
$2 → number of lines
```

Example:

```bash
./log_generator.sh sample_log.log 100
```

Therefore:

```text
$1 = sample_log.log
$2 = 100
$# = 2
```

---

# 2. Arrays

### Log levels

```bash
log_levels=("INFO" "DEBUG" "ERROR" "WARNING" "CRITICAL")
```

This creates a Bash array.

You can access its elements using indexes:

```text
0 → INFO
1 → DEBUG
2 → ERROR
3 → WARNING
4 → CRITICAL
```

---

# 3. `${#array[@]}`

This:

```bash
${#log_levels[@]}
```

returns the number of elements in the array.

For example:

```text
INFO
DEBUG
ERROR
WARNING
CRITICAL
```

There are 5 elements.

---

# 4. `$RANDOM`

Bash provides the special variable:

```bash
$RANDOM
```

which generates a pseudo-random integer.

You use:

```bash
RANDOM % ${#log_levels[@]}
```

to generate an index within the array range.

Conceptually:

```text
RANDOM
   ↓
Modulo array length
   ↓
Random index
   ↓
Random log level
```

---

# 5. `local`

Inside the function:

```bash
local log_level="..."
local error_msg=""
```

`local` keeps the variables scoped to the function.

This is something you learned on **Day 18**.

---

# 6. Function

You created:

```bash
generate_log_line() {
    ...
}
```

Then called it inside the loop:

```bash
generate_log_line >> "$log_file_path"
```

This demonstrates the progression from your earlier scripting exercises:

```text
Day 18
Functions
   ↓
Day 20
Functions + Arrays + Loops
```

---

# 7. For Loop

```bash
for ((i=0; i<num_lines; i++)); do
    generate_log_line >> "$log_file_path"
done
```

If you run:

```bash
./log_generator.sh sample_log.log 100
```

the function runs **100 times**.

---

# 🔄 Complete Workflow

You now have two scripts that work together:

```text
             log_generator.sh
                    │
                    ↓
          Generate sample_log.log
                    │
                    ↓
              log_analyzer.sh
                    │
       ┌────────────┼────────────┐
       ↓            ↓            ↓
   Count Errors   Critical    Top Errors
       │           Events          │
       └────────────┼───────────────┘
                    ↓
             Generate Report
                    │
                    ↓
        log_report_<date>.txt
```

This is a much better Day 20 project than testing the analyzer only against manually created data.

---

# 🧪 Complete Test

### Step 1 – Generate a log

```bash
./log_generator.sh sample_log.log 100
```

### Step 2 – Verify the number of lines

```bash
wc -l sample_log.log
```

Expected:

```text
100 sample_log.log
```

### Step 3 – Check errors

```bash
grep -Ei "ERROR|Failed" sample_log.log
```

### Step 4 – Check critical events

```bash
grep -n "CRITICAL" sample_log.log
```

### Step 5 – Run your analyzer

```bash
./log_analyzer.sh sample_log.log
```

### Step 6 – Check the report

```bash
cat log_report_$(date +%Y-%m-%d).txt
```

---

# ⚠️ Small Improvement to Your Generator

Your current generator creates an error message **only when the level is `ERROR`**:

```bash
if [ "$log_level" == "ERROR" ]; then
```

So `CRITICAL` entries look like:

```text
2026-09-04 04:20:03 [CRITICAL]  - 19873
```

If you want your log analyzer to have meaningful `CRITICAL` messages as well, you can create a separate array:

```bash
critical_messages=(
    "Disk space below threshold"
    "Database connection lost"
    "Application crashed"
    "Service unavailable"
)
```

Then:

```bash
if [ "$log_level" == "ERROR" ]; then
    error_msg="${error_messages[$((RANDOM % ${#error_messages[@]}))]}"
elif [ "$log_level" == "CRITICAL" ]; then
    error_msg="${critical_messages[$((RANDOM % ${#critical_messages[@]}))]}"
fi
```

That would produce more realistic logs:

```text
2026-09-04 04:20:03 [CRITICAL] Database connection lost - 19873
2026-09-04 04:20:04 [ERROR] Disk full - 28761
2026-09-04 04:20:05 [CRITICAL] Service unavailable - 12345
```



```text
log_generator.sh
       ↓
Generate test data
       ↓
sample_log.log
       ↓
log_analyzer.sh
       ↓
Analyze logs
       ↓
grep + awk + sort + uniq
       ↓
Generate report
       ↓
log_report_YYYY-MM-DD.txt
```

