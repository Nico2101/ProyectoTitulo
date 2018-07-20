package com.app.proyectotitulo.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;

import com.app.proyectotitulo.TO.GraficoActividadesTO;
import com.app.proyectotitulo.TO.GraficoResumenReprogramacionTO;
import com.app.proyectotitulo.TO.PlanTO;

public class GraficoResumenReprogramacionDAO {

	private static final String GET_RESUMEN = "select pe.nombre, count(*) as total from Reprogramacion r join Actividad_Realizada ar on r.id_actividad_realizada=ar.id_actividad_realizada join Actividad a on ar.id_actividad=a.id_actividad join Plan_Ejecucion pe on a.id_plan_ejecucion=pe.id_plan_ejecucion group by pe.id_plan_ejecucion";
	private static final String GET_ACTIVIDIDADES_REPROGRAMADAS = "select a.nombre as nombreActividad, pe.nombre as nombrePlan, count(*) as total from Reprogramacion r join Actividad_Realizada ar on r.id_actividad_realizada=ar.id_actividad_realizada join Actividad a on ar.id_actividad=a.id_actividad join Plan_Ejecucion pe on a.id_plan_ejecucion=pe.id_plan_ejecucion group by a.id_actividad limit 10";

	/*
	 * private static final String DB_NAME = "npfuente"; private static final String
	 * PORT = "3306"; private static final String URL = "jdbc:mysql://localhost:" +
	 * PORT + "/" + DB_NAME; private static final String USER = "root"; private
	 * static final String PASSWORD = "";
	 */

	private static final String DB_NAME = "npfuente";
	private static final String PORT = "3306";
	private static final String URL = "jdbc:mysql://146.83.196.166:" + PORT + "/" + DB_NAME + "?autoReconnect=true";
	private static final String USER = "npfuente";
	private static final String PASSWORD = "mbe26nco1CIx";

	public LinkedList<GraficoActividadesTO> getTotalActividaesReprogramdas() {
		LinkedList<GraficoActividadesTO> datos = new LinkedList<>();
		GraficoActividadesTO result = null;

		Connection conn = null;

		try {
			conn = getConnection();
			PreparedStatement ps = conn.prepareStatement(GET_ACTIVIDIDADES_REPROGRAMADAS);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				result = new GraficoActividadesTO();
				result.setNombreActividad(rs.getString("nombreActividad"));
				result.setTotal(rs.getInt("total"));
				result.setNombrePlan(rs.getString("nombrePlan"));

				datos.add(result);
			}
		} catch (SQLException e1) {
			e1.printStackTrace();
			System.err.println("Error al conectar con la base de datos");
		}

		return datos;

	}

	public LinkedList<GraficoResumenReprogramacionTO> getResumen() {
		LinkedList<GraficoResumenReprogramacionTO> datos = new LinkedList<>();
		GraficoResumenReprogramacionTO result = null;

		Connection conn = null;

		try {
			conn = getConnection();
			PreparedStatement ps = conn.prepareStatement(GET_RESUMEN);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				result = new GraficoResumenReprogramacionTO();
				result.setNombrePlan(rs.getString("nombre"));
				result.setTotal(rs.getInt("total"));

				datos.add(result);
			}
		} catch (SQLException e1) {
			e1.printStackTrace();
			System.err.println("Error al conectar con la base de datos");
		}

		return datos;

	}

	public Connection getConnection() {
		Connection conn = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = (Connection) DriverManager.getConnection(URL, USER, PASSWORD);
		} catch (ClassNotFoundException | SQLException e1) {
			e1.printStackTrace();
			System.err.println("Error al conectar con la base de datos");
		}
		return conn;
	}

}
