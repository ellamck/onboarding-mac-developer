# APFS Diagram and Short Explanation

<img width="817" height="479" alt="Screenshot 2026-08-24 at 14 57 03" src="https://github.com/user-attachments/assets/f66d1391-3f51-4228-a6e1-3759911bcc46" />

Notes: 

- Preboot, VM and Recovery volumes are hidden to the User, are never duplicated and are shared.
- A data volume is created for each additional System Volume.

## Additional Notes

- A single drive holds one APFS container, and each container has the above 5 volumes _minimum_.
- Time Machine backups and system updates use Snapshots, which are a snapshot, read-only copy of a volume's state.
- The APFS container's total available space is the total size of the container - space used in all volumes in the container.
- The volumes are shared the free space from the APFS container when needed.
- APFS supports per-volume encryption.
- When a file is duplicated, APFS doesn't copy the data at first, only when changes are made to a copy, this is called "Copy-on-write".
- The volumes share the free space in the container, so the space allocation is dynamic. 
