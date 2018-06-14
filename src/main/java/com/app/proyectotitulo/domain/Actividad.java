package com.app.proyectotitulo.domain;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import java.util.List;

/**
 * The persistent class for the Actividad database table.
 * 
 */
@Entity
@NamedQuery(name = "Actividad.findAll", query = "SELECT a FROM Actividad a")
public class Actividad implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id_actividad")
	private int idActividad;

	@Column(name = "actividad_eliminada")
	private boolean actividadEliminada;

	@Column(name = "actividad_cosecha")
	private boolean actividadCosecha;

	private String nombre;

	private int orden;

	// bi-directional many-to-one association to Plan_Ejecucion
	@ManyToOne
	@JoinColumn(name = "id_plan_ejecucion")
	@JsonManagedReference
	private Plan_Ejecucion planEjecucion;

	// bi-directional many-to-one association to Actividad_Realizada
	@OneToMany(mappedBy = "actividad")
	@JsonBackReference
	private List<Actividad_Realizada> actividadRealizadas;

	public Actividad() {
	}

	public int getOrden() {
		return orden;
	}

	public void setOrden(int orden) {
		this.orden = orden;
	}

	public boolean isActividadCosecha() {
		return actividadCosecha;
	}

	public void setActividadCosecha(boolean actividadCosecha) {
		this.actividadCosecha = actividadCosecha;
	}

	public int getIdActividad() {
		return this.idActividad;
	}

	public void setIdActividad(int idActividad) {
		this.idActividad = idActividad;
	}

	public boolean getActividadEliminada() {
		return this.actividadEliminada;
	}

	public void setActividadEliminada(boolean actividadEliminada) {
		this.actividadEliminada = actividadEliminada;
	}

	public String getNombre() {
		return this.nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public Plan_Ejecucion getPlanEjecucion() {
		return this.planEjecucion;
	}

	public void setPlanEjecucion(Plan_Ejecucion planEjecucion) {
		this.planEjecucion = planEjecucion;
	}

	public List<Actividad_Realizada> getActividadRealizadas() {
		return this.actividadRealizadas;
	}

	public void setActividadRealizadas(List<Actividad_Realizada> actividadRealizadas) {
		this.actividadRealizadas = actividadRealizadas;
	}

	public Actividad_Realizada addActividadRealizada(Actividad_Realizada actividadRealizada) {
		getActividadRealizadas().add(actividadRealizada);
		actividadRealizada.setActividad(this);

		return actividadRealizada;
	}

	public Actividad_Realizada removeActividadRealizada(Actividad_Realizada actividadRealizada) {
		getActividadRealizadas().remove(actividadRealizada);
		actividadRealizada.setActividad(null);

		return actividadRealizada;
	}

}