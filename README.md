[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/rXX1_Uiw)
## Project 00
### NeXTCS
### Period: 09
## Name0: Eungman Joo
## Name1: OTHER NAME HERE (delete this line if you are working solo)
---

This project will be completed in phases. The first phase will be to work on this document. Use github-flavoured markdown. (For more markdown help [click here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) or [here](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax) )

All projects will require the following:
- Researching new forces to implement.
- Method for each new force, returning a `PVector`  -- similar to `getGravity` and `getSpring` (using whatever parameters are necessary).
- A distinct demonstration for each individual force (including gravity and the spring force).
- A visual menu at the top providing information about which simulation is currently active and indicating whether movement is on or off.
- The ability to toggle movement on/off
- The ability to toggle bouncing on/off
- The user should be able to switch _between_ simluations using the number keys as follows:
  - `1`: Gravity
  - `2`: Spring Force
  - `3`: Drag
  - `4`: Custom Force
  - `5`: Combination


## Phase 0: Force Selection, Analysis & Plan
---------- 

#### Custom Force: Electro-Magnetic Forces(2 components: Electric and Magnetic)

### Forumla
What is the formula for your force? Including descriptions/definitions for the symbols. (You may include a picture of the formula if it is not easily typed.)

$F_e = \frac {k_e q_A q_B}{r^2} \hat {AB}$

$F_B = ((q_A v_A B_B)sin θ) \hat {AB}$

### Custom Force
- What information that is already present in the `Orb` or `OrbNode` classes does this force use?
  - The distance between orbs and the velocity of each orb

- Does this force require any new constants, if so what are they and what values will you try initially?
  - The electrostatic constant(I will try to use 1 and figure it out from there)
  - The absolute value of the charge of an electron(I will try to use 0.1 and figure it out from there)
  - The permittivity of magnetic flux in free space(I will try to use 0.01 and figure it out from there)

- Does this force require any new information to be added to the `Orb` class? If so, what is it and what data type will you use?
  - Charges of each orb(boolean)
  - If each orb is divided into electrons and protons, then they will exert both electrostatic and magnetic forces since they are moving charges
  - Initially, I will try with only single electrons to keep it simple
  - If I make a more complex model, charges will be ints that include negative and positive signs, and charges will also depend on size and mass

- Does this force interact with other `Orbs`, or is it applied based on the environment?
  - It is an Orb-Orb interactive force

- In order to calculate this force, do you need to perform extra intermediary calculations? If so, what?
  - Yes, the magnetic field strength created by moving charges

--- 

### Simulation 1: Gravity
Describe how you will attempt to simulate orbital motion.

--- 

### Simulation 2: Spring
Describe what your spring simulation will look like. Explain how it will be setup, and how it should behave while running.

YOUR ANSWER HERE

--- 

### Simulation 3: Drag
Describe what your drag simulation will look like. Explain how it will be setup, and how it should behave while running.

YOUR ANSWER HERE

--- 

### Simulation 4: Custom force
Describe what your Custom force simulation will look like. Explain how it will be setup, and how it should behave while running.

YOUR ANSWER HERE

--- 

### Simulation 5: Combination
Describe what your combination simulation will look like. Explain how it will be setup, and how it should behave while running.

YOUR ANSWER HERE

