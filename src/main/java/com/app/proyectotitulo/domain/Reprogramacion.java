package com.app.proyectotitulo.domain;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonManagedReference;

import java.util.Date;

/**
 * The persistent class for the Reprogramacion database table.
 * 
 */
@Entity
@NamedQuery(name = "Reprogramacion.findAll", query = "SELECT r FROM Reprogramacion r")
public class Reprogramacion implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id_reprogramacion")
	private int idReprogramacion;

	@Temporal(TemporalType.DATE)
	@Column(name = "fecha_estimada_anterior")
	private Date fechaEstimadaAnterior;

	@Temporal(TemporalType.DATE)
	@Column(name = "fecha_reprogramacion")
	private Date fechaReprogramacion;

	private String motivo;

	// bi-directional many-to-one association to Actividad_Realizada
	@ManyToOne
	@JoinColumn(name = "id_actividad_realizada")
	@JsonManagedReference
	private Actividad_Realizada actividadRealizada;

	public Reprogramacion() {
	}

	public int getIdReprogramacion() {
		return this.idReprogramacion;
	}

	public void setIdReprogramacion(int idReprogramacion) {
		this.idReprogramacion = idReprogramacion;
	}

	public Date getFechaReprogramacion() {
		return this.fechaReprogramacion;
	}

	public void setFechaReprogramacion(Date fechaReprogramacion) {
		this.fechaReprogramacion = fechaReprogramacion;
	}

	public String getMotivo() {
		return this.motivo;
	}

	public void setMotivo(String motivo) {
		this.motivo = motivo;
	}

	public Actividad_Realizada getActividadRealizada() {
		return this.actividadRealizada;
	}

	public void setActividadRealizada(Actividad_Realizada actividadRealizada) {
		this.actividadRealizada = actividadRealizada;
	}

	public Date getFechaEstimadaAnterior() {
		return fechaEstimadaAnterior;
	}

	public void setFechaEstimadaAnterior(Date fechaEstimadaAnterior) {
		this.fechaEstimadaAnterior = fechaEstimadaAnterior;
	}

}