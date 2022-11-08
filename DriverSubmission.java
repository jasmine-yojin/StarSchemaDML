
import java.sql.*;
import java.util.Vector;

import javax.swing.JOptionPane;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;

public class Driver {

	public static void main(String[] args) {
		try {
			
			String connectionUrl = "jdbc:sqlserver://occam-dbserver.cs.qc.cuny.edu\\dbclass:21433;databaseName=tsqlv4;encrypt=false;";
			String user="student";
			String pass = "fall2022";
			
			String connectionUrl1 = "jdbc:sqlserver://<Enter Your Path here>;databaseName=BiClass;encrypt=false;";
			String user1="sa";
			String pass1 = "PH@123456789";
			
			//1. get a connection to database
				Connection con =  DriverManager.getConnection(connectionUrl1, user1, pass1); 
			
			//2. create a statement
				Statement myStmt = con.createStatement();
			
			//3. Execute a sql query
				myStmt.executeQuery("EXEC Project2.LoadStarSchemaData;");
				ResultSet rs = myStmt.executeQuery("SELECT * FROM process.workflowsteps;");
				
		   //4.JTable		
				JTable table = new JTable(buildTableModel(rs));
				JOptionPane.showMessageDialog(null, new JScrollPane(table));
				
			
				
		  		
				ResultSet analysis = myStmt.executeQuery("SELECT datediff (millisecond, MIN(startingdatedate), MAX(EndingDateTime)) as DurationinMillisecond FROM Process.WorkflowSteps");
				JTable table2 = new JTable(buildTableModel(analysis));
				JOptionPane.showMessageDialog(null, new JScrollPane(table2));
				
			
				
			
		}catch (Exception exc) {
			exc.printStackTrace();
		}

	}
	
	public static DefaultTableModel buildTableModel(ResultSet rs)
	        throws SQLException {

	    ResultSetMetaData metaData = rs.getMetaData();

	    // names of columns
	    Vector<String> columnNames = new Vector<String>();
	    int columnCount = metaData.getColumnCount();
	    for (int column = 1; column <= columnCount; column++) {
	        columnNames.add(metaData.getColumnName(column));
	    }

	    // data of the table
	    Vector<Vector<Object>> data = new Vector<Vector<Object>>();
	    while (rs.next()) {
	        Vector<Object> vector = new Vector<Object>();
	        for (int columnIndex = 1; columnIndex <= columnCount; columnIndex++) {
	            vector.add(rs.getObject(columnIndex));
	        }
	        data.add(vector);
	    }

	    return new DefaultTableModel(data, columnNames);

	}

}
