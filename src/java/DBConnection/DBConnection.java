/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DBConnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Nevets
 */
public class DBConnection {

    private Connection conn = null;
    private boolean isconnected = false;
    private boolean isconnectionvalid = false;

    public DBConnection() {
    }

    public Connection createConnection() {
        try {

            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/vidur?useSSL=false&allowPublicKeyRetrieval=true", "root", "******");
            isconnected = true;
        } catch (Exception e) {
            System.out.println(e);
        }
        return conn;
    }

    public void closeConnection() {
        try {
            conn.close();
            isconnected = false;
        } catch (Exception e) {
            isconnected = false;
        }
    }
}
