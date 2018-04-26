package com.app.proyectotitulo.domain;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import java.util.List;

/**
 * The persistent class for the Predio database table.
 * 
 */
@Entity
@NamedQuery(name = "Predio.findAll", query = "SELECT p FROM Predio p")
public class Predio implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id_predio")
	private int idPredio;

	private String estado;

	private String nombre;

	@Column(name = "predio_eliminado")
	private boolean predioEliminado;

	private Integer superficie;

	// bi-directional many-to-one association to Actividad_Realizada
	@OneToMany(mappedBy = "predio")
	@JsonBackReference
	private List<Actividad_Realizada> actividadRealizadas;

	// bi-directional many-to-one association to Sector
	@ManyToOne
	@JoinColumn(name = "id_sector")
	@JsonManagedReference
	private Sector sector;

	public Predio() {
	}

	public int getIdPredio() {
		return this.idPredio;
	}

	public void setIdPredio(int idPredio) {
		this.idPredio = idPredio;
	}

	public String getEstado() {
		return this.estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public String getNombre() {
		return this.nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public boolean getPredioEliminado() {
		return this.predioEliminado;
	}

	public void setPredioEliminado(boolean predioEliminado) {
		this.predioEliminado = predioEliminado;
	}

	public Integer getSuperficie() {
		return this.superficie;
	}

	public void setSuperficie(Integer superficie) {
		this.superficie = superficie;
	}

	public List<Actividad_Realizada> getActividadRealizadas() {
		return this.actividadRealizadas;
	}

	public void setActividadRealizadas(List<Actividad_Realizada> actividadRealizadas) {
		this.actividadRealizadas = actividadRealizadas;
	}

	public Actividad_Realizada addActividadRealizada(Actividad_Realizada actividadRealizada) {
		getActividadRealizadas().add(actividadRealizada);
		actividadRealizada.setPredio(this);

		return actividadRealizada;
	}

	public Actividad_Realizada removeActividadRealizada(Actividad_Realizada actividadRealizada) {
		getActividadRealizadas().remove(actividadRealizada);
		actividadRealizada.setPredio(null);

		return actividadRealizada;
	}

	public Sector getSector() {
		return this.sector;
	}

	public void setSector(Sector sector) {
		this.sector = sector;
	}

}