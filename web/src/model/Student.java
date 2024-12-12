package model;

public class Student {
    private int id;
    private String studentId;
    private String fullName;
    private int term;
    private String classId;
    private String className;
    private String courseId;
    private String courseName;

    public Student(int id, String studentId, String fullName, int term, String classId, String className, String courseId, String courseName) {
        this.id = id;
        this.studentId = studentId;
        this.fullName = fullName;
        this.term = term;
        this.classId = classId;
        this.className = className;
        this.courseId = courseId;
        this.courseName = courseName;
    }

    // Getters and Setters
    public int getId() { return id; }
    public String getStudentId() { return studentId; }
    public String getFullName() { return fullName; }
    public int getTerm() { return term; }
    public String getClassId() { return classId; }
    public String getClassName() { return className; }
    public String getCourseId() { return courseId; }
    public String getCourseName() { return courseName; }
}
