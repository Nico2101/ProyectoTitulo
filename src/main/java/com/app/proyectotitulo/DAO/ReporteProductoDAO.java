package com.app.proyectotitulo.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;

import com.app.proyectotitulo.TO.PlanTO;
import com.app.proyectotitulo.TO.ReporteProductoTO;

public class ReporteProductoDAO {

	private static final String OBTENER_COSECHA_PRODUCTO_TEMPORADAS = "SELECT t.id_temporada, t.nombre AS temporada,t.fecha_inicio, t.fecha_termino, IFNULL( SUM( ar.cantidad_cosechada ) , 0 ) AS cantidad_cosechada FROM Actividad_Realizada ar JOIN Actividad a ON ar.id_actividad = a.id_actividad JOIN Plan_Ejecucion pe ON a.id_plan_ejecucion = pe.id_plan_ejecucion JOIN Temporada t ON ar.id_temporada = t.id_temporada WHERE pe.plan_eliminado =0 AND pe.id_plan_ejecucion =? GROUP BY t.id_temporada";
	private static final String GET_PLANES = "SELECT pe.id_plan_ejecucion, pe.nombre from Plan_Ejecucion pe where pe.plan_eliminado=0";
	private static final String GET_COSTO_TEMPORADA = "select ifnull(sum(ai.costo),0) as costos from Actividad_Insumo ai join Actividad_Realizada ar on ai.id_actividad_realizada=ar.id_actividad_realizada join Temporada t on ar.id_temporada=t.id_temporada where t.id_temporada=?";

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

	public LinkedList<PlanTO> planes() {
		LinkedList<PlanTO> planes = new LinkedList<>();
		PlanTO result = null;
		Connection conn = null;

		try {
			conn = getConnection();
			PreparedStatement ps = conn.prepareStatement(GET_PLANES);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				result = new PlanTO();
				result.setId(rs.getInt("id_plan_ejecucion"));
				result.setNombre(rs.getString("nombre"));

				planes.add(result);
			}
		} catch (SQLException e1) {
			e1.printStackTrace();
			System.err.println("Error al conectar con la base de datos");
		}

		return planes;
	}

	public LinkedList<ReporteProductoTO> getDatosCosechaProducto(int id_plan_ejecucion) {
		Connection conn = null;
		ReporteProductoTO result = null;
		LinkedList<ReporteProductoTO> lista = new LinkedList<>();

		try {
			conn = getConnection();
			PreparedStatement ps = conn.prepareStatement(OBTENER_COSECHA_PRODUCTO_TEMPORADAS);
			ps.setInt(1, id_plan_ejecucion);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				result = new ReporteProductoTO();

				result.setNombreTemporada(rs.getString("temporada"));
				result.setFechaInicio(rs.getDate("fecha_inicio"));
				result.setFechaTermino(rs.getDate("fecha_termino"));
				result.setCantidadCosechada(rs.getInt("cantidad_cosechada"));

				// Obtener el costo de incurrido en esa temporada
				PreparedStatement ps2 = conn.prepareStatement(GET_COSTO_TEMPORADA);
				ps2.setInt(1, rs.getInt("id_temporada"));
				ResultSet rs2 = ps2.executeQuery();
				if (rs2.next()) {
					result.setCosto(rs2.getInt("costos"));
				}

				lista.add(result);
			}
		} catch (SQLException e1) {
			e1.printStackTrace();
			System.err.println("Error al conectar con la base de datos");
		}

		return lista;
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
