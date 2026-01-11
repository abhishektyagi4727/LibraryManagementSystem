package com.library.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class DbConnection {

    private static final String URL =
            "jdbc:mysql://localhost:3306/library_db?createDatabaseIfNotExist=true";
    private static final String USER = "root";
    private static final String PASS = "081996";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws Exception {
        Connection con = DriverManager.getConnection(URL, USER, PASS);
        createTables(con);
        return con;
    }

    private static void createTables(Connection con) throws Exception {
        Statement st = con.createStatement();

        st.execute(
            "CREATE TABLE IF NOT EXISTS admin (" +
            "admin_id INT AUTO_INCREMENT PRIMARY KEY," +
            "username VARCHAR(50) UNIQUE," +
            "password VARCHAR(50)," +
            "name VARCHAR(40)," +
            "email VARCHAR(50)) ENGINE=InnoDB");

        st.execute(
            "CREATE TABLE IF NOT EXISTS student (" +
            "student_id INT AUTO_INCREMENT PRIMARY KEY," +
            "username VARCHAR(50) UNIQUE," +
            "password VARCHAR(50)," +
            "name VARCHAR(40)," +
            "email VARCHAR(50)," +
            "phone VARCHAR(15)," +
            "course VARCHAR(50)," +
            "semester VARCHAR(10)) ENGINE=InnoDB");

        st.execute(
            "CREATE TABLE IF NOT EXISTS book (" +
            "book_id INT AUTO_INCREMENT PRIMARY KEY," +
            "title VARCHAR(100)," +
            "author VARCHAR(100)," +
            "quantity INT," +
            "status VARCHAR(20) DEFAULT 'active') ENGINE=InnoDB");

        st.execute(
            "CREATE TABLE IF NOT EXISTS book_request (" +
            "request_id INT AUTO_INCREMENT PRIMARY KEY," +
            "book_id INT," +
            "student_id INT," +
            "request_date DATE," +
            "status VARCHAR(50) DEFAULT 'pending'," +
            "FOREIGN KEY (book_id) REFERENCES book(book_id)," +
            "FOREIGN KEY (student_id) REFERENCES student(student_id)) ENGINE=InnoDB");

        st.execute(
            "CREATE TABLE IF NOT EXISTS issue (" +
            "issue_id INT AUTO_INCREMENT PRIMARY KEY," +
            "student_id INT," +
            "book_id INT," +
            "issue_date DATE," +
            "return_date DATE," +
            "status VARCHAR(50)," +
            "FOREIGN KEY (student_id) REFERENCES student(student_id)," +
            "FOREIGN KEY (book_id) REFERENCES book(book_id)) ENGINE=InnoDB");

        st.close();
    }
}
