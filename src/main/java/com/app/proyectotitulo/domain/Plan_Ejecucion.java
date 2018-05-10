package com.app.proyectotitulo.domain;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import java.util.Date;
import java.util.List;

/**
 * The persistent class for the Plan_Ejecucion database table.
 * 
 */
@Entity
@NamedQuery(name = "Plan_Ejecucion.findAll", query = "SELECT p FROM Plan_Ejecucion p")
public class Plan_Ejecucion implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id_plan_ejecucion")
	private int idPlanEjecucion;

	@Column(name = "fecha_creacion")
	private Date fechaCreacion;

	private String nombre;

	@Column(name = "plan_eliminado")
	private boolean planEliminado;

	// bi-directional many-to-one association to Actividad
	@OneToMany(mappedBy = "planEjecucion")
	@JsonBackReference
	private List<Actividad> actividads;

	// bi-directional many-to-one association to Empleado
	@ManyToOne
	@JoinColumn(name = "rut")
	@JsonManagedReference
	private Empleado empleado;

	public Plan_Ejecucion() {
	}

	public int getIdPlanEjecucion() {
		return this.idPlanEjecucion;
	}

	public void setIdPlanEjecucion(int idPlanEjecucion) {
		this.idPlanEjecucion = idPlanEjecucion;
	}

	public Date getFechaCreacion() {
		return this.fechaCreacion;
	}

	public void setFechaCreacion(Date fechaCreacion) {
		this.fechaCreacion = fechaCreacion;
	}

	public String getNombre() {
		return this.nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public boolean getPlanEliminado() {
		return this.planEliminado;
	}

	public void setPlanEliminado(boolean planEliminado) {
		this.planEliminado = planEliminado;
	}

	public List<Actividad> getActividads() {
		return this.actividads;
	}

	public void setActividads(List<Actividad> actividads) {
		this.actividads = actividads;
	}

	public Actividad addActividad(Actividad actividad) {
		getActividads().add(actividad);
		actividad.setPlanEjecucion(this);

		return actividad;
	}

	public Actividad removeActividad(Actividad actividad) {
		getActividads().remove(actividad);
		actividad.setPlanEjecucion(null);

		return actividad;
	}

	public Empleado getEmpleado() {
		return this.empleado;
	}

	public void setEmpleado(Empleado empleado) {
		this.empleado = empleado;
	}

}