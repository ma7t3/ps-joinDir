# Folder Merger Script (PowerShell)

This PowerShell script merges the contents of multiple similarly structured folders into a unified folder structure.

## 🔍 What It Does

Given a source directory containing multiple folders (e.g. `Folder1`, `Folder2`, etc.), each with a similar internal structure like:

```
Folder1/
├── model/
│ └── model1.obj
├── texture/
│ └── texture1.dds
└── file1.txt

Folder2/
├── model/
│ └── model2.obj
├── texture/
│ └── texture2.dds
└── file2.txt
```

The script produces a unified target folder like:

```
Merged/
├── model/
│ ├── model1.obj
│ └── model2.obj
├── texture/
│ ├── texture1.dds
│ └── texture2.dds
├── file1.txt
└── file2.txt
```

## ⚙️ Usage

1. Open PowerShell.
2. Modify the paths in the script:
   - `$sourceRoot` – the folder containing your structured subfolders.
   - `$targetRoot` – where the merged files should go.
3. Run the script:
   - Right-click the `.ps1` file and select **"Run with PowerShell"**.
   - Or run it from a PowerShell session:
     ```powershell
     Set-ExecutionPolicy RemoteSigned -Scope Process
     .\merge-folders.ps1
     ```

## 📁 Notes

- The script skips itself during copying.
- Files are grouped into common subfolders (like `model`, `texture`) in the target directory.
- Files with the same name **will be overwritten**. You can modify the script to rename duplicates if needed.
