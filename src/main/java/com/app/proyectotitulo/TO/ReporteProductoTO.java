package com.app.proyectotitulo.TO;

import java.sql.Date;

public class ReporteProductoTO {

	private String nombreTemporada;
	private Date fechaInicio;
	private Date fechaTermino;
	private int cantidadCosechada;

	public String getNombreTemporada() {
		return nombreTemporada;
	}

	public void setNombreTemporada(String nombreTemporada) {
		this.nombreTemporada = nombreTemporada;
	}

	public Date getFechaInicio() {
		return fechaInicio;
	}

	public void setFechaInicio(Date fechaInicio) {
		this.fechaInicio = fechaInicio;
	}

	public Date getFechaTermino() {
		return fechaTermino;
	}

	public void setFechaTermino(Date fechaTermino) {
		this.fechaTermino = fechaTermino;
	}

	public int getCantidadCosechada() {
		return cantidadCosechada;
	}

	public void setCantidadCosechada(int cantidadCosechada) {
		this.cantidadCosechada = cantidadCosechada;
	}

}
