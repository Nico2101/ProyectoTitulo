package com.app.proyectotitulo.domain;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonBackReference;

import java.util.Date;
import java.util.List;

/**
 * The persistent class for the Temporada database table.
 * 
 */
@Entity
@NamedQuery(name = "Temporada.findAll", query = "SELECT t FROM Temporada t")
public class Temporada implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id_temporada")
	private int idTemporada;

	private boolean estado;

	@Temporal(TemporalType.DATE)
	@Column(name = "fecha_inicio")
	private Date fechaInicio;

	@Temporal(TemporalType.DATE)
	@Column(name = "fecha_termino")
	private Date fechaTermino;

	private String nombre;

	@Column(name = "temporada_eliminada")
	private boolean temporadaEliminada;

	// bi-directional many-to-one association to Actividad_Realizada
	@OneToMany(mappedBy = "temporada")
	@JsonBackReference
	private List<Actividad_Realizada> actividadRealizadas;

	public Temporada() {
	}

	public int getIdTemporada() {
		return this.idTemporada;
	}

	public void setIdTemporada(int idTemporada) {
		this.idTemporada = idTemporada;
	}

	public boolean getEstado() {
		return this.estado;
	}

	public void setEstado(boolean estado) {
		this.estado = estado;
	}

	public Date getFechaInicio() {
		return this.fechaInicio;
	}

	public void setFechaInicio(Date fechaInicio) {
		this.fechaInicio = fechaInicio;
	}

	public Date getFechaTermino() {
		return this.fechaTermino;
	}

	public void setFechaTermino(Date fechaTermino) {
		this.fechaTermino = fechaTermino;
	}

	public String getNombre() {
		return this.nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public boolean getTemporadaEliminada() {
		return this.temporadaEliminada;
	}

	public void setTemporadaEliminada(boolean temporadaEliminada) {
		this.temporadaEliminada = temporadaEliminada;
	}

	public List<Actividad_Realizada> getActividadRealizadas() {
		return this.actividadRealizadas;
	}

	public void setActividadRealizadas(List<Actividad_Realizada> actividadRealizadas) {
		this.actividadRealizadas = actividadRealizadas;
	}

	public Actividad_Realizada addActividadRealizada(Actividad_Realizada actividadRealizada) {
		getActividadRealizadas().add(actividadRealizada);
		actividadRealizada.setTemporada(this);

		return actividadRealizada;
	}

	public Actividad_Realizada removeActividadRealizada(Actividad_Realizada actividadRealizada) {
		getActividadRealizadas().remove(actividadRealizada);
		actividadRealizada.setTemporada(null);

		return actividadRealizada;
	}

}