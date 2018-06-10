package com.app.proyectotitulo.TO;

import java.util.LinkedList;

public class DatosCosechaTO {

	private String nombrePlan;
	private LinkedList<ReporteProductoTO> datos;

	public String getNombrePlan() {
		return nombrePlan;
	}

	public void setNombrePlan(String nombrePlan) {
		this.nombrePlan = nombrePlan;
	}

	public LinkedList<ReporteProductoTO> getDatos() {
		return datos;
	}

	public void setDatos(LinkedList<ReporteProductoTO> datos) {
		this.datos = datos;
	}

}
