package model;

public class Course {
    private int courseId;
    private String name;
    private String grade;

    // Default constructor
    public Course() {
    }

    // Constructor with parameters
    public Course(int courseId, String name, String grade) {
        this.courseId = courseId;
        this.name = name;
        this.grade = grade;
    }

    // Getters and Setters
    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    // Override toString() method for easy debugging
    @Override
    public String toString() {
        return "Course [courseId=" + courseId + ", name=" + name + ", grade=" + grade + "]";
    }
}
