# Julia Set


## 📜 Description
The **JuliaSet** program is a hybrid project developed in C and assembly language. It utilizes the Allegro graphics library for rendering and displaying fractal visualizations. 

## 📝 Note

This game was created for "Computer Architecture" course during my first year of studies at Warsaw University of Technology. The project was transferred from my academic account on GitLab.

## ✅ Requirements

1. **Software requirements**:
   - **C language**: C11 or newer

2. **Libraries used**:
   - **Cmake**: 3.25.1
   - **Allegro**: 5.2.8

## 💾 Installation

1. Install required libraries on your system:
   
  - For **Ubuntu** or **Debian-based** systems:
    
    ```sh
    sudo apt update
    sudo apt install cmake liballegro5-dev liballegro5-dev
    ```
   
  - For **Fedora** or **Red Hat-based** systems:
    
    ```sh
    sudo dnf install cmake allegro-devel allegro-font-devel
    ```
    
  - For **macOS** using Homebrew:
    
    ```sh
    brew install cmake allegro
    ```

2. Clone repository:
   
   ```sh
   git clone https://github.com/MaciejCieslik1/JuliaSet.git
   ```

3. Navigate to the project **JuliaSet** directory:
   
    ```sh
    cd JuliaSet
    ```

4. Create **build** directory:
   
    ```sh
    mkdir build
    ```

5. Navigate to the project **build** directory:
   
    ```sh
    cd build
    ```

6. Generate necessary makefiles in the **build** directory:
    
    ```sh
    cmake ..
    ```

7. Compile program:
    
    ```sh
    make
    ```

8. Run the program:
   
    ```sh
    ./julia
    ```

## 🎯 Usage
Arrow Keys:  
   Adjust the real and imaginary parts of the complex constant **C**.
   - Left Arrow: Decrease cRealcReal
   - Right Arrow: Increase cRealcReal
   - Up Arrow: Increase cImaginarycImaginary
   - Down Arrow: Decrease cImaginarycImaginary

W/A/S/D Keys:  
   Move the view of the fractal.
   - W: Move up
   - A: Move left
   - S: Move down
   - D: Move right

Zoom Controls:  
   Change the size of the fractal.
   - -(minus): Zoom out
   - = (equals): Zoom in

Exit:  
   Press Esc to close the application.

For more info about Julia's Set, click [HERE](https://en.wikipedia.org/wiki/Julia_set). 

## 📁 Project Structure

```bash
JuliaSet/   # Contains all project files and directories
│
├── build/       # Contains makefiles and files generated automatically
│
└── screenshots/ # screenshots
```

## 📜 License
This project is licensed under the MIT License. See the [LICENSE](https://github.com/MaciejCieslik1/ShipsGame/blob/master/LICENCE) file for details.

## 📬 Contact
For questions, feedback, or support:
- **Author**: Maciej Cieślik
- **LinkedIn**: [Maciej Cieślik](https://www.linkedin.com/in/maciej-cie%C5%9Blik-1ab60a290/)
- **Instagram**: [@maciek_cieslik](https://www.instagram.com/maciek_cieslik)
- **GitHub**: [MaciejCieslik1](https://github.com/MaciejCieslik1)
- **Support**: Email [maciej.cieslik.official@gmail.com](mailto:maciej.cieslik.official@gmail.com)
