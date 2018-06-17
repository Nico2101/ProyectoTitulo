package com.app.proyectotitulo.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;

import com.app.proyectotitulo.TO.ActividadInsumoTO;

public class DetallesCostosDAO {

	private static final String OBTENER_DETALLES_COSTOS = "SELECT ai.id_insumo as idInsumo, SUM( ai.costo ) as costos, i.nombre as nombre, i.tipo as tipo, i.unidad_medida as unidadMedida FROM Actividad_Insumo ai join Insumo i on ai.id_insumo=i.id_insumo join Actividad_Realizada ar on ai.id_actividad_realizada=ar.id_actividad_realizada where ar.id_Temporada=? and ar.id_predio=? GROUP BY ai.id_insumo";

	private static final String DB_NAME = "npfuente";
	private static final String PORT = "3306";
	private static final String URL = "jdbc:mysql://146.83.196.166:" + PORT + "/" + DB_NAME;
	private static final String USER = "npfuente";
	private static final String PASSWORD = "mbe26nco1CIx";

	public LinkedList<ActividadInsumoTO> detallesCostos(int idPredio, int idTemporada) {
		System.out.println(idPredio);
		System.out.println(idTemporada);
		LinkedList<ActividadInsumoTO> costos = new LinkedList<>();
		ActividadInsumoTO result = null;
		Connection conn = null;

		try {
			conn = getConnection();
			PreparedStatement ps = conn.prepareStatement(OBTENER_DETALLES_COSTOS);
			ps.setInt(1, idTemporada);
			ps.setInt(2, idPredio);
			
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				result = new ActividadInsumoTO();
				result.setIdInsumo(rs.getInt("idInsumo"));
				result.setCostosInsumo(rs.getInt("costos"));
				result.setNombre(rs.getString("nombre"));
				result.setTipo(rs.getString("tipo"));
				result.setUnidadDeMedida(rs.getString("unidadMedida"));
				
				costos.add(result);

			}
		} catch (SQLException e1) {
			e1.printStackTrace();
			System.err.println("Error al conectar con la base de datos: inventario");
		}
		
		return costos;

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
