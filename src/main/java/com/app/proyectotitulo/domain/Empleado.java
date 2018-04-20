package com.app.proyectotitulo.domain;

import java.io.Serializable;
import javax.persistence.*;
import javax.validation.constraints.NotEmpty;

import com.fasterxml.jackson.annotation.JsonBackReference;

import java.util.Date;
import java.util.List;

/**
 * The persistent class for the empleado database table.
 * 
 */
@Entity
@NamedQuery(name = "Empleado.findAll", query = "SELECT e FROM Empleado e")
public class Empleado implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@NotEmpty(message = "Debe ingresar su rut")
	private String rut;

	private String apellidos;

	private String cargo;

	@NotEmpty(message = "Debe ingresar su contraseña")
	private String clave;

	private String direccion;

	@Temporal(TemporalType.DATE)
	@Column(name = "fecha_nac")
	private Date fechaNac;

	private String nombre;

	private String telefono;

	// bi-directional many-to-one association to PlanEjecucion
	@OneToMany(mappedBy = "empleado")
	@JsonBackReference
	private List<PlanEjecucion> planEjecucions;

	public Empleado() {
	}

	public String getRut() {
		return this.rut;
	}

	public void setRut(String rut) {
		this.rut = rut;
	}

	public String getApellidos() {
		return this.apellidos;
	}

	public void setApellidos(String apellidos) {
		this.apellidos = apellidos;
	}

	public String getCargo() {
		return this.cargo;
	}

	public void setCargo(String cargo) {
		this.cargo = cargo;
	}

	public String getClave() {
		return this.clave;
	}

	public void setClave(String clave) {
		this.clave = clave;
	}

	public String getDireccion() {
		return this.direccion;
	}

	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}

	public Date getFechaNac() {
		return this.fechaNac;
	}

	public void setFechaNac(Date fechaNac) {
		this.fechaNac = fechaNac;
	}

	public String getNombre() {
		return this.nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getTelefono() {
		return this.telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public List<PlanEjecucion> getPlanEjecucions() {
		return this.planEjecucions;
	}

	public void setPlanEjecucions(List<PlanEjecucion> planEjecucions) {
		this.planEjecucions = planEjecucions;
	}

	public PlanEjecucion addPlanEjecucion(PlanEjecucion planEjecucion) {
		getPlanEjecucions().add(planEjecucion);
		planEjecucion.setEmpleado(this);

		return planEjecucion;
	}

	public PlanEjecucion removePlanEjecucion(PlanEjecucion planEjecucion) {
		getPlanEjecucions().remove(planEjecucion);
		planEjecucion.setEmpleado(null);

		return planEjecucion;
	}

}