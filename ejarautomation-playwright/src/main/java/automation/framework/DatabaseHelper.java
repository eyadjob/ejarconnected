package automation.framework;

import automation.framework.propmanager.PropManager;

import java.sql.*;

public class DatabaseHelper {

    private static String strSql;
    private static Statement stmtSQL;
    private java.sql.Connection con = null;
    private java.sql.Connection conCustomerRepo = null;


    public void deleteBookingWithReference(String bookingId) {
        if (bookingId != null && !bookingId.isEmpty()) {
            System.out.println("we in deleting the booking with id :" + bookingId);
            executeQueryWithoutReturnResult("DELETE FROM Rental.Bookings WHERE BookingNumber='" + bookingId + "'");
        } else {
            System.out.println("You need to provide valid booking id to delete from Rental.Bookings table");
        }
    }

    public void deletePaymentAttemptsWithReference(String bookingId) {
        try {
            if (bookingId != null && !bookingId.isEmpty()) {
                System.out.println("we in deleting the booking with id :" + bookingId);
                ResultSet e = executeQuery("SELECT id FROM Rental.Bookings WHERE BookingNumber ='" + bookingId + "'");
                String bookingIdNotNumber = "";
                while (e.next()) {
                    bookingIdNotNumber = e.getString("id");
                }
                if (!bookingIdNotNumber.isEmpty())
                    executeQueryWithoutReturnResult("DELETE FROM dbo.OnlinePaymentAttempts WHERE ReferenceId='" + bookingIdNotNumber + "'");
                else
                    System.out.println("No booking id returned from teh booking number");
            } else {
                System.out.println("You need to provide valid booking id to delete from Rental.Bookings table");
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

    public void deletePaymentAttemptsByUserEmail(String userEmail) {
        if (userEmail != null && !userEmail.isEmpty()) {
            System.out.println("we in deleting the booking with for user with email :" + userEmail);
            executeQueryWithoutReturnResult("DELETE op\n" +
                    "  FROM " + PropManager.getInstance().getProperty("ejar.database") + ".[Crm].[LiteCustomers] as cu \n" +
                    "  LEFT JOIN " + PropManager.getInstance().getProperty("ejar.database") + ".[Rental].Bookings as bok \n" +
                    "  ON bok.driverId = cu.id\n" +
                    "  LEFT JOIN  " + PropManager.getInstance().getProperty("ejar.database") + ".[dbo].[OnlinePaymentAttempts] as op\n" +
                    "  ON op.referenceId = bok.id\n" +
                    "  WHERE cu.Email = '" + userEmail + "'");
        } else {
            System.out.println("You need to provide valid email id to delete from the online payment attempts");
        }
    }


    public void deleteRelatedBookings(String userEmail) {
        if (userEmail != null && !userEmail.isEmpty()) {
            System.out.println("we in deleting the booking with for user with email :" + userEmail);
            executeQueryWithoutReturnResult("DELETE bok\n" +
                    "  FROM " + PropManager.getInstance().getProperty("ejar.database") + ".[Crm].[LiteCustomers] as cu \n" +
                    "  LEFT JOIN " + PropManager.getInstance().getProperty("ejar.database") + ".[Rental].Bookings as bok \n" +
                    "  ON bok.driverId = cu.id\n" +
                    "  WHERE cu.Email = '" + userEmail + "'");
            executeQueryWithoutReturnResult("DELETE bok\n" +
                    "  FROM " + PropManager.getInstance().getProperty("ejar.database") + ".[Crm].[LiteCustomers] as cu \n" +
                    "  LEFT JOIN " + PropManager.getInstance().getProperty("ejar.database") + ".[Rental].PartnerBookings as bok \n" +
                    "  ON bok.LightCustomerId = cu.id\n" +
                    "  WHERE cu.Email = '" + userEmail + "'");

        } else {
            System.out.println("You need to provide valid email id to delete from the online payment attempts");
        }
    }

    public void deleteRelatedBookingsFromCustomerRepo(String userEmail) {
        if (userEmail != null && !userEmail.isEmpty()) {
            System.out.println("we in deleting the booking with for user with email :" + userEmail);
            executeQueryWithoutReturnResult( getConnection(PropManager.getInstance().getProperty("ejar.databaseCustomerRepo"),PropManager.getInstance().getProperty("ejar.databaseUserName"), PropManager.getInstance().getProperty("ejar.databaseUserPassword")),
                    "DELETE bok\n" +
                            "  FROM " + PropManager.getInstance().getProperty("ejar.databaseCustomerRepo") + ".[Crm].[LiteCustomers] as cu \n" +
                            "  LEFT JOIN " + PropManager.getInstance().getProperty("ejar.databaseCustomerRepo") + ".Aggregator.Bookings as bok \n" +
                            "  ON bok.CustomerId = cu.id\n" +
                            "  WHERE cu.Email = '" + userEmail + "'");
        } else {
            System.out.println("You need to provide valid email id to delete from the online payment attempts");
        }
    }



    private String getConnectionUrl() {
        return "jdbc:sqlserver://" + PropManager.getInstance().getProperty("ejar.databaseIp") + ";databaseName=" + PropManager.getInstance().getProperty("ejar.database");
    }

    private String getConnectionUrl(String databaseIp, String databaseName) {
        return "jdbc:sqlserver://" + databaseIp + ";databaseName=" + databaseName;
    }

    private java.sql.Connection getConnection(String connectionUrl, String databaseUserName, String databasePassword) {
        try {
//			DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver());
            System.out.println(getConnectionUrl());

            con = java.sql.DriverManager.getConnection(getConnectionUrl(), PropManager.getInstance().getProperty("ejar.databaseUserName"), PropManager.getInstance().getProperty("ejar.databaseUserPassword"));
            if (con != null) {
                System.out.println("Connection Successful!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error Trace in getConnection() : " + e.getMessage());
        }
        return con;
    }


    private java.sql.Connection getConnection() {
        try {
//			DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver());
            System.out.println(getConnectionUrl());

            con = java.sql.DriverManager.getConnection(getConnectionUrl(), PropManager.getInstance().getProperty("ejar.databaseUserName"), PropManager.getInstance().getProperty("ejar.databaseUserPassword"));
            if (con != null) {
                System.out.println("Connection Successful!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error Trace in getConnection() : " + e.getMessage());
        }
        return con;
    }

    public void printConnectionParams(DatabaseMetaData dm) {
        try {
            System.out.println("Driver Information");
            System.out.println("Driver Name: " + dm.getDriverName());
            System.out.println("Driver Version: " + dm.getDriverVersion());
            System.out.println("Database Information ");
            System.out.println("Database Name: " + dm.getDatabaseProductName());
            System.out.println("Database Version: " + dm.getDatabaseProductVersion());
            System.out.println("Avalilable Catalogs ");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void executeQueryWithoutReturnResult(String query) {
        try {
            con = this.getConnection();
            if (con != null) {
                printConnectionParams(con.getMetaData());
                stmtSQL = con.createStatement();
                System.out.println("query is : " + query);
                stmtSQL.execute(query);
            } else {
                System.out.println("Error: No active Connection");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }



    public void executeQueryWithoutReturnResult(Connection con, String query) {
        try {
            con = this.getConnection();
            if (con != null) {
                printConnectionParams(con.getMetaData());
                stmtSQL = con.createStatement();
                System.out.println("query is : " + query);
                stmtSQL.execute(query);
            } else {
                System.out.println("Error: No active Connection");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    /*
     * Display the driver properties, database details
     */
    public ResultSet executeQuery(String query) {
        DatabaseMetaData dm = null;
        ResultSet rs = null;
        try {
            con = this.getConnection();
            if (con != null) {
                dm = con.getMetaData();
                System.out.println("Driver Information");
                System.out.println("Driver Name: " + dm.getDriverName());
                System.out.println("Driver Version: " + dm.getDriverVersion());
                System.out.println("Database Information ");
                System.out.println("Database Name: " + dm.getDatabaseProductName());
                System.out.println("Database Version: " + dm.getDatabaseProductVersion());
                System.out.println("Avalilable Catalogs ");
                rs = dm.getCatalogs();
                // Show all databases within the connection.
                while (rs.next()) {
                    System.out.println("	catalog: " + rs.getString(1));
                }
                rs.close();

                stmtSQL = con.createStatement();

                System.out.println("query is : " + query);
                ResultSet rs1 = stmtSQL.executeQuery(query);

                return rs1;

            } else {
                System.out.println("Error: No active Connection");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return null;
    }

    private void closeConnection() {
        try {
            if (con != null) {
                con.close();
            }
            con = null;
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}



