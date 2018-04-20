package com.app.proyectotitulo.domain;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the plan_ejecucion database table.
 * 
 */
@Entity
@Table(name="plan_ejecucion")
@NamedQuery(name="PlanEjecucion.findAll", query="SELECT p FROM PlanEjecucion p")
public class PlanEjecucion implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="id_plan_ejecucion")
	private int idPlanEjecucion;

	@Column(name="fecha_creacion")
	private String fechaCreacion;

	private String nombre;

	//bi-directional many-to-one association to Actividad
	@OneToMany(mappedBy="planEjecucion")
	private List<Actividad> actividads;

	//bi-directional many-to-one association to Empleado
	@ManyToOne
	@JoinColumn(name="rut")
	private Empleado empleado;

	public PlanEjecucion() {
	}

	public int getIdPlanEjecucion() {
		return this.idPlanEjecucion;
	}

	public void setIdPlanEjecucion(int idPlanEjecucion) {
		this.idPlanEjecucion = idPlanEjecucion;
	}

	public String getFechaCreacion() {
		return this.fechaCreacion;
	}

	public void setFechaCreacion(String fechaCreacion) {
		this.fechaCreacion = fechaCreacion;
	}

	public String getNombre() {
		return this.nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
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