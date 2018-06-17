package com.app.proyectotitulo.TO;

public class ActividadInsumoTO {

	private int idInsumo;
	private int costosInsumo;
	private String  nombre;
	private String tipo; 
	private String unidadDeMedida;

	public int getIdInsumo() {
		return idInsumo;
	}

	public void setIdInsumo(int idInsumo) {
		this.idInsumo = idInsumo;
	}

	public int getCostosInsumo() {
		return costosInsumo;
	}

	public void setCostosInsumo(int costosInsumo) {
		this.costosInsumo = costosInsumo;
	}
	
	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre= nombre;
	}
	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo= tipo;
	}
	
	
	public String getUnidadDeMedida() {
		return unidadDeMedida;
	}

	public void setUnidadDeMedida(String unidadDeMedida) {
		this.unidadDeMedida= unidadDeMedida;
	}

}