---

# 🧱 Single-Clock Parameterized FIFO

### **Verilog RTL + UVM Verification (Beginner-Friendly Project)**

---

## 📌 Project Status

| Item                   | Status                       |
| ---------------------- | ---------------------------- |
| **RTL Design**         | ✅ Completed                  |
| **UVM Testbench**      | 🟡 In Progress               |
| **Code Coverage Goal** | 🎯 100%                      |
| **UVM Version**        | UVM 1.2 / IEEE 1800.2        |
| **Compatibility**      | All SystemVerilog Simulators |

---

## ▶️ EDA Playground Version (Online Simulation)

You can run the simplified FIFO + Basic UVM test directly on **EDA Playground**
**(No installation required — perfect for beginners).**

👉 **Link:** *(https://www.edaplayground.com/x/nKpq)*

**Folders included in EDA Playground version:**

* `/rtl/fifo.v` (Main FIFO)
* `/uvm/basic_testbench.sv` (Lightweight UVM testbench)
* `/uvm/basic_test.sv` (Simple fill & drain test)

**This version is meant for:**
* Students
* Freshers
* Quick demo
* Interview practice
* Anyone who wants to run the FIFO instantly

---

## 📘 Overview

This repository contains:

* A **parameterized single-clock FIFO RTL**
* A clean **UVM environment** to verify the FIFO
* Beginner-friendly documentation
* A **playground version** for quick online execution

The FIFO uses:

* Binary counters
* Circular read/write pointers
* Single synchronous clock
* Active-low sync reset

---

## 📁 Repository Structure

```
.
├── src/
│   └── rtl/
│       └── fifo.v
│
├── docs/
│   ├── PROJECT_AGENDA.md
│   └── UVM_VERIFICATION_PLAN.md
│
└── uvm/
    ├── tb/
    └── sv/
```

---

## 🔧 RTL Design Specifications

**File:** `src/rtl/fifo.v`

### Parameters

| Parameter    | Description           | Default |
| ------------ | --------------------- | ------- |
| `DATA_WIDTH` | Data width            | 8       |
| `ADDR_WIDTH` | Determines FIFO depth | 4       |

### Local Parameters

| Parameter | Formula           | Description   |
| --------- | ----------------- | ------------- |
| `DEPTH`   | `1 << ADDR_WIDTH` | Total entries |

---

## 🔌 Port Details

| Port        | Dir | Width         | Description        |
| ----------- | --- | ------------- | ------------------ |
| `clk`       | In  | 1             | Clock              |
| `rst_n`     | In  | 1             | Active-low reset   |
| `wr_en`     | In  | 1             | Write enable       |
| `wr_data`   | In  | DATA_WIDTH    | Input data         |
| `wr_full`   | Out | 1             | FIFO full flag     |
| `rd_en`     | In  | 1             | Read enable        |
| `rd_data`   | Out | DATA_WIDTH    | Output data        |
| `rd_empty`  | Out | 1             | FIFO empty flag    |
| `occupancy` | Out | log₂(DEPTH+1) | Current fill level |

---

## 🧪 UVM Verification Environment

### What We Verify:

* FIFO write/read operations
* Full & Empty behavior
* Concurrent read + write
* Data integrity
* Occupancy counter correctness
* Coverage closure (functional + line + toggle)

### UVM Components Included:

* Transaction
* Sequence
* Driver
* Monitor
* Scoreboard (FIFO model)
* Agent
* Environment
* Tests

---

## 🚀 Getting Started (Local Simulation)

### 1️⃣ Go to simulation directory

```
cd uvm/tb/
```

### 2️⃣ Compile

```
./compile.sh
```

### 3️⃣ Run any test

```
./run.sh +UVM_TESTNAME=basic_fill_drain_test
```

Concurrent RW:

```
./run.sh +UVM_TESTNAME=concurrent_rw
```

---

## 🏆 Future Additions

* Add SV Assertions
* Add functional coverage models
* Add async FIFO version
* Add GUI waveform scripts

---

## 🤝 Contributions

Anyone can contribute — beginner-friendly project.
Open for enhancements, bug fixes, documentation improvements.

---


