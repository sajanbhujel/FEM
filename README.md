# Finite Element Analysis (FEA) of a 4-Node Quadrilateral Element (Plane Stress) in MATLAB

This repository contains MATLAB code for symbolic and numerical implementation of the Finite Element Method (FEM) to analyze a single 4-node quadrilateral element under **plane stress** conditions. The analysis includes stiffness matrix formulation, application of loads and boundary conditions, displacement solution, and stress evaluation at Gauss points.

## 💡 Problem Description

We model a 2D structure composed of a single 4-node quadrilateral finite element with specified nodal coordinates and material properties. The objective is to:

- Compute the element stiffness matrix symbolically using shape functions and Gauss integration.
- Apply boundary conditions (fixed edge).
- Apply a uniform downward load.
- Solve for nodal displacements.
- Compute stresses at Gauss points.

## 📐 Element Geometry

The nodes are defined as:

Node 1: (0, 1)
Node 2: (0, 0)
Node 3: (2, 0.5)
Node 4: (2, 1)

## ⚙️ Material Properties

- Young's Modulus: `E = 3 × 10⁷ Pa`
- Poisson’s Ratio: `ν = 0.3`
- Assumed condition: **Plane Stress**

## 🧮 Numerical Integration

- **Gauss Quadrature** with 2×2 points is used for numerical integration.
- Symbolic stiffness integrand is evaluated at Gauss points using `matlabFunction`.

## 🧾 Boundary Conditions

- Nodes 1 and 2 are fully fixed (DOFs 1–4).
- A uniform **downward load of 20 N/m** is applied to Nodes 1 and 4 (top edge).

## 📊 Output

The code displays:

- **Nodal Displacements** in x and y directions.
- **Stresses** (`σ_xx`, `σ_yy`, `τ_xy`) at each Gauss point.

## 📁 File Structure

├── fem_quad4_plane_stress.m # Main MATLAB script └── README.md # Project description


## 📌 Notes

- This implementation uses **symbolic math** for stiffness matrix derivation.
- For real-world applications, this method should be expanded to a mesh of elements with global assembly.
- This serves as a building block for more advanced FEA solvers in MATLAB.

## 📈 Future Work

- Extend to multiple elements (mesh).
- Add visualization of deformation and stress distribution.
- Support for plane strain conditions.
- Export results to VTK or other visualization formats.

## 🧑‍💻 Author

**Sajan Bhujel**

Feel free to use, modify, and extend this code for educational and research purposes.

---

> If you find this useful, consider ⭐ starring the repository or contributing to future extensions!
