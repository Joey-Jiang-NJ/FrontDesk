# README

The goal of FrontDesk is to create an intuitive platform that bridges the gap between trainees and faculty in medical institutions. By integrating case management, self-assessment tools, and feedback mechanisms, FrontDesk ensures seamless communication, personalized learning, and efficient scheduling. 

Here is a brief introduction of the three user types:

Trainee: Medical students in their training process.
Faculty: Doctors responsible for leading trainees through medical cases.
Scheduler: The person responsible for assigning trainees to medical cases.

### Trainee

After clicking the trainee button, the trainee must first select a trainee and click the "Confirm" button. Once confirmed, the "Go to Main View" button will appear, allowing access to the Trainee Main View.

1. **In the Trainee Main View**:
   If the trainee is assigned to a case, two buttons will be displayed: "Current Case" and "Complete.”

  -  Clicking "Current Case" provides details about the current case, including the assigned faculty's preferences.
  -  Clicking "Complete" allows the user to mark the case as finished.

2. The second tabis the Case Log View, where users can add new case logs. However, due to Miguel's requirements, existing logs cannot be edited. Within each case log, users can complete a self-reflection and save it.
3. The third tab is the Personal Information View:

  - Alternatively, users can access this page by clicking the profile photo in the top-right corner.
  - In this view, users can edit personal information, including uploading a profile photo and updating their first name, last name, and email on the server.
  - Note: Uploaded photos are limited to a resolution of 10 or lower due to server restrictions, which may result in unclear image quality.
  - After making changes, users can click "Save" to store the updated information.
  - This view also provides access to the Rotation History.
  - We use the default rotation information here since we still have not receive all the details of the rotation.

### Faculty

### User Guide

1. **Fake Login**: Select an existing registered faculty account to log in.  
   - Choose one of the accounts and verify it.  
   - Click "Confirm," and the "Go to Faculty View" button will appear.  
   - Click "Go to Faculty View" to navigate to the faculty main page.  

2. **Edit Personal Information**: Update your name, email, and preferences.  
   - Click "Person Info" to view and edit personal information.  
   - Click "Preferences" to update faculty preferences.  

3. **Check Trainee Information**: Access detailed trainee information assigned by the scheduler.  
   - Click "Trainee Info" to navigate to the "All Trainees" page.  
   - Trainee cards in the list display the trainees assigned to the faculty for a case.  
   - Click on a trainee card to view detailed trainee information:  
     - **Rotation History**: View the trainee's active and past rotations.  
     - **Faculty Evaluation**: Navigate to the Faculty Evaluation page to assess the trainee's performance for the case.  
       - After completing the evaluation and clicking the "Save" button, the faculty will end the case.  
       - The trainee will then be marked as available for other cases.

### Scheduler

The Scheduler interface features two tab views, allowing the scheduler to manage both active cases and trainee information.

1. **Trainees View**:
   In the Trainees tab, the scheduler can view a list of all trainees, which includes their name, ID, and availability status. By clicking on a trainee, the scheduler can access more detailed information about them. A trainee is marked as "Available" if they are not currently assigned to any case.

2. **Cases View**:
   In the Cases tab, the scheduler is presented with a list of all active cases along with brief case information. Clicking on a specific case provides a detailed view split into two sections:

   **Top Half**: Displays detailed information about the selected case.
   **Bottom Half**: Shows a list of all trainees who are currently available for assignment.
   The scheduler can select one or multiple trainees from the available list and assign them to the case by clicking the Save Selection button. After assignment, the selected trainees are marked as "not available." The scheduler can repeat this process to assign more trainees to a case as needed.

   Once a trainee is assigned to a case:

   - The trainee gains access to the relevant case details.
   - Faculty associated with the case can view the list of all assigned trainees.
   
Access to backend repo: https://gitlab.oit.duke.edu/zj96/frontdesk_server
