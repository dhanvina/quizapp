# Quiz App Web Flow

## 1. Splash Screen
- **Description:** The initial screen of the app that displays the logo and app name.
- **Purpose:** 
  - Provides a brief introduction to the app.
  - Engages users with a visual welcome.
- **Actions:**
  - Automatically transitions to the Dashboard after a short delay (e.g., 3 seconds).
  - Optionally, include a "Get Started" button.

---

## 2. Dashboard
- **Description:** The main hub where users can access various features.
- **Purpose:** 
  - Centralized access to key functionalities like Practice Tests and Live Test.
- **Sections:**
  - **Practice Test:** Link to access the practice test section.
  - **Live Test:** Link to access the Live test section.
- **Actions:**
  - Users can select a feature to navigate to, such as starting a Practice Test.

---

## 3. Practice Test
- **Description:** The section where users can take quizzes to practice.
- **Purpose:** 
  - Allows users to test their knowledge and improve through practice.
- **Structure:**
  - **Question Display:** Shows one question at a time with multiple-choice answers.
  - **Answer Selection:** Allows users to choose an answer.
  - **Progress Tracker:** Indicates the user's current progress in the test.
  - **Submit Button:** Allows users to submit their answers and get results.
- **Actions:**
  - Users can answer each question and move to the next.
  - Final submission displays a score and performance summary.

---

## 4. Live Quiz
- **Description:** A real-time quiz section where users can participate in live quizzes with others.
- **Purpose:** 
  - Provides a competitive, engaging environment where users can test their knowledge in real time.
  - Allows users to compete with peers or other online participants.

- **Structure:**
  - **Countdown Timer:** Displays the time left until the quiz begins, allowing users to prepare.
  - **Question Display:** Shows one question at a time, synchronized for all participants.
  - **Answer Options:** Users can select multiple-choice answers within a set time limit for each question.
  - **Real-Time Progress Tracker:** Shows the current question number and total questions, allowing users to track their progress.
  - **Results Summary:** Final screen showing the score.

- **Actions:**
  - Upon quiz completion, view the overall score.
