Here is the `README.md` content you can use for your project. It includes the download link, extraction steps for all major operating systems, and the correct directory paths to ensure OWASP Dependency-Check version 11.x recognizes the pre-cached database.

---

# README.md

## Dependency-Check NVD Data (Pre-cached)

This package contains a pre-filled H2 database (`odc.mv.db`) for OWASP Dependency-Check v11.0. Use this to skip the time-consuming NVD API data download on new hosts or air-gapped environments.

### 1. Download the Data

Download the zip file from the following link:


[nvd-data-11.zip](https://drive.google.com/file/d/1GwVC4uUZUxIA3ukz7AGYca745H1bXju9/view?usp=sharing) 

### 2. Extraction Paths

For Dependency-Check to recognize the data, you must extract the contents so that the `11.0` folder is placed in the specific directory used by your tool.

| OS | Tool Type | Extraction Path (Target Directory) |
| --- | --- | --- |
| **Windows** | Maven | `C:\Users\<Your-Username>\.m2\repository\org\owasp\dependency-check-data\` |
| **Windows** | CLI | `<Dependency-Check-Installation-Dir>\data\` |
| **Linux/Mac** | Maven | `~/.m2/repository/org/owasp/dependency-check-data/` |
| **Linux/Mac** | CLI | `<Dependency-Check-Installation-Dir>/data/` |

---

### 3. Extraction Steps

#### **Windows**

1. Locate the downloaded `nvd-data-11.zip`.
2. Right-click the file and select **Extract All...**.
3. In the destination field, browse to or paste the path for your tool (e.g., `%USERPROFILE%\.m2\repository\org\owasp\dependency-check-data\`).
4. Ensure that after extraction, the file path is exactly `.../dependency-check-data/11.0/odc.mv.db`.

#### **macOS**

1. Open **Terminal**.
2. Create the directory if it doesn't exist:
```bash
mkdir -p ~/.m2/repository/org/owasp/dependency-check-data/

```


3. Extract the file:
```bash
unzip ~/Downloads/nvd-data-11.zip -d ~/.m2/repository/org/owasp/dependency-check-data/

```



#### **Linux**

1. Open your terminal.
2. Ensure the target directory exists:
```bash
mkdir -p ~/.m2/repository/org/owasp/dependency-check-data/

```


3. Use the `unzip` command:
```bash
unzip nvd-data-11.zip -d ~/.m2/repository/org/owasp/dependency-check-data/

```



---

### 4. Running Dependency-Check

To ensure the tool uses this local database and does not attempt to contact the NVD API, use the `noupdate` flag:

* **CLI:** `dependency-check.bat --project "My Project" --scan "path/to/project" --noupdate`
* **Maven:** `mvn org.owasp:dependency-check-maven:check -DautoUpdate=false`
* **Gradle:** `dependencyCheck { autoUpdate = false }`