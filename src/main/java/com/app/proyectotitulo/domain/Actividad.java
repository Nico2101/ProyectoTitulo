package com.app.proyectotitulo.domain;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import java.util.List;

/**
 * The persistent class for the actividad database table.
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

	private boolean habilitado;

	private String nombre;

	// bi-directional many-to-one association to PlanEjecucion
	@ManyToOne
	@JoinColumn(name = "id_plan_ejecucion")
	@JsonManagedReference
	private PlanEjecucion planEjecucion;

	// bi-directional many-to-one association to ActividadRealizada
	@OneToMany(mappedBy = "actividad")
	@JsonBackReference
	private List<ActividadRealizada> actividadRealizadas;

	public Actividad() {
	}

	public int getIdActividad() {
		return this.idActividad;
	}

	public void setIdActividad(int idActividad) {
		this.idActividad = idActividad;
	}

	public boolean getHabilitado() {
		return this.habilitado;
	}

	public void setHabilitado(boolean habilitado) {
		this.habilitado = habilitado;
	}

	public String getNombre() {
		return this.nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public PlanEjecucion getPlanEjecucion() {
		return this.planEjecucion;
	}

	public void setPlanEjecucion(PlanEjecucion planEjecucion) {
		this.planEjecucion = planEjecucion;
	}

	public List<ActividadRealizada> getActividadRealizadas() {
		return this.actividadRealizadas;
	}

	public void setActividadRealizadas(List<ActividadRealizada> actividadRealizadas) {
		this.actividadRealizadas = actividadRealizadas;
	}

	public ActividadRealizada addActividadRealizada(ActividadRealizada actividadRealizada) {
		getActividadRealizadas().add(actividadRealizada);
		actividadRealizada.setActividad(this);

		return actividadRealizada;
	}

	public ActividadRealizada removeActividadRealizada(ActividadRealizada actividadRealizada) {
		getActividadRealizadas().remove(actividadRealizada);
		actividadRealizada.setActividad(null);

		return actividadRealizada;
	}

}