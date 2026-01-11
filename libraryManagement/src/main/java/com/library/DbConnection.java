package com.library;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class DbConnection 
{
	static Statement st=null;
	static Connection con=null;
	static 
	{
		try
		{
		Class.forName("com.mysql.cj.jdbc.Driver");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	public static Connection getConnection() throws Exception
	{
		  con= DriverManager.getConnection("jdbc:mysql://localhost:3306/library_db?createDatabaseIfNotExist=true",
				"root", "081996");
		 st=con.createStatement();
			createTables();
		 return con;
	}
	private static void createTables() throws Exception {
		st.execute("CREATE TABLE IF NOT EXISTS admin (" + "admin_id INT PRIMARY KEY AUTO_INCREMENT, "
				+ "username VARCHAR(50) UNIQUE, " + "password VARCHAR(50), " + "name VARCHAR(40), "
				+ "email VARCHAR(50)" + ")");

		st.execute("CREATE TABLE IF NOT EXISTS student (" + "student_id INT PRIMARY KEY AUTO_INCREMENT, "
				+ "username VARCHAR(50) UNIQUE, " + "password VARCHAR(50), " + "name VARCHAR(40)" + ")");

		st.execute("CREATE TABLE IF NOT EXISTS book (" + "book_id INT PRIMARY KEY AUTO_INCREMENT, "
				+ "title VARCHAR(100), " + "author VARCHAR(100), " + "quantity INT" + ")");

		st.execute("CREATE TABLE IF NOT EXISTS issue (" + "issue_id INT PRIMARY KEY AUTO_INCREMENT, "
				+ "student_id INT, " + "book_id INT, " + "issue_date DATE, " + "return_date DATE, "
				+ "status VARCHAR(50), " + "FOREIGN KEY (student_id) REFERENCES student(student_id), "
				+ "FOREIGN KEY (book_id) REFERENCES book(book_id)" + ")");

		st.execute("CREATE TABLE IF NOT EXISTS book_request (" + "request_id INT PRIMARY KEY AUTO_INCREMENT, "
				+ "book_id INT, " + "student_id INT, " + "request_date DATE, "
				+ "status VARCHAR(50) DEFAULT 'pending', " + "FOREIGN KEY (book_id) REFERENCES book(book_id), "
				+ "FOREIGN KEY (student_id) REFERENCES student(student_id)" + ")");

	}
}
