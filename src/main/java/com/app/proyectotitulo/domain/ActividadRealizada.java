package com.app.proyectotitulo.domain;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import java.util.Date;
import java.util.List;

/**
 * The persistent class for the actividad_realizada database table.
 * 
 */
@Entity
@Table(name = "actividad_realizada")
@NamedQuery(name = "ActividadRealizada.findAll", query = "SELECT a FROM ActividadRealizada a")
public class ActividadRealizada implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id_actividad_realizada")
	private int idActividadRealizada;

	@Column(name = "cantidad_cosechada")
	private Integer cantidadCosechada;

	@Temporal(TemporalType.DATE)
	@Column(name = "fecha_ejecucion_real")
	private Date fechaEjecucionReal;

	@Temporal(TemporalType.DATE)
	@Column(name = "fecha_estimada")
	private Date fechaEstimada;

	// bi-directional many-to-one association to ActividadInsumo
	@OneToMany(mappedBy = "actividadRealizada")
	@JsonBackReference
	private List<ActividadInsumo> actividadInsumos;

	// bi-directional many-to-one association to Actividad
	@ManyToOne
	@JoinColumn(name = "id_actividad")
	@JsonManagedReference
	private Actividad actividad;

	// bi-directional many-to-one association to Predio
	@ManyToOne
	@JoinColumn(name = "id_predio")
	@JsonManagedReference
	private Predio predio;

	// bi-directional many-to-one association to Temporada
	@ManyToOne
	@JoinColumn(name = "id_temporada")
	@JsonManagedReference
	private Temporada temporada;

	// bi-directional many-to-one association to Reprogramacion
	@OneToMany(mappedBy = "actividadRealizada")
	@JsonBackReference
	private List<Reprogramacion> reprogramacions;

	public ActividadRealizada() {
	}

	public int getIdActividadRealizada() {
		return this.idActividadRealizada;
	}

	public void setIdActividadRealizada(int idActividadRealizada) {
		this.idActividadRealizada = idActividadRealizada;
	}

	public Integer getCantidadCosechada() {
		return this.cantidadCosechada;
	}

	public void setCantidadCosechada(Integer cantidadCosechada) {
		this.cantidadCosechada = cantidadCosechada;
	}

	public Date getFechaEjecucionReal() {
		return this.fechaEjecucionReal;
	}

	public void setFechaEjecucionReal(Date fechaEjecucionReal) {
		this.fechaEjecucionReal = fechaEjecucionReal;
	}

	public Date getFechaEstimada() {
		return this.fechaEstimada;
	}

	public void setFechaEstimada(Date fechaEstimada) {
		this.fechaEstimada = fechaEstimada;
	}

	public List<ActividadInsumo> getActividadInsumos() {
		return this.actividadInsumos;
	}

	public void setActividadInsumos(List<ActividadInsumo> actividadInsumos) {
		this.actividadInsumos = actividadInsumos;
	}

	public ActividadInsumo addActividadInsumo(ActividadInsumo actividadInsumo) {
		getActividadInsumos().add(actividadInsumo);
		actividadInsumo.setActividadRealizada(this);

		return actividadInsumo;
	}

	public ActividadInsumo removeActividadInsumo(ActividadInsumo actividadInsumo) {
		getActividadInsumos().remove(actividadInsumo);
		actividadInsumo.setActividadRealizada(null);

		return actividadInsumo;
	}

	public Actividad getActividad() {
		return this.actividad;
	}

	public void setActividad(Actividad actividad) {
		this.actividad = actividad;
	}

	public Predio getPredio() {
		return this.predio;
	}

	public void setPredio(Predio predio) {
		this.predio = predio;
	}

	public Temporada getTemporada() {
		return this.temporada;
	}

	public void setTemporada(Temporada temporada) {
		this.temporada = temporada;
	}

	public List<Reprogramacion> getReprogramacions() {
		return this.reprogramacions;
	}

	public void setReprogramacions(List<Reprogramacion> reprogramacions) {
		this.reprogramacions = reprogramacions;
	}

	public Reprogramacion addReprogramacion(Reprogramacion reprogramacion) {
		getReprogramacions().add(reprogramacion);
		reprogramacion.setActividadRealizada(this);

		return reprogramacion;
	}

	public Reprogramacion removeReprogramacion(Reprogramacion reprogramacion) {
		getReprogramacions().remove(reprogramacion);
		reprogramacion.setActividadRealizada(null);

		return reprogramacion;
	}

}