package com.app.proyectotitulo.domain;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonManagedReference;

/**
 * The persistent class for the actividad_insumo database table.
 * 
 */
@Entity
@Table(name = "actividad_insumo")
@NamedQuery(name = "ActividadInsumo.findAll", query = "SELECT a FROM ActividadInsumo a")
public class ActividadInsumo implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id_actividad_insumo")
	private int idActividadInsumo;

	private Integer cantidad;

	private Integer costo;

	// bi-directional many-to-one association to ActividadRealizada
	@ManyToOne
	@JoinColumn(name = "id_actividad_realizada")
	@JsonManagedReference
	private ActividadRealizada actividadRealizada;

	// bi-directional many-to-one association to Insumo
	@ManyToOne
	@JoinColumn(name = "id_insumo")
	@JsonManagedReference
	private Insumo insumo;

	public ActividadInsumo() {
	}

	public int getIdActividadInsumo() {
		return this.idActividadInsumo;
	}

	public void setIdActividadInsumo(int idActividadInsumo) {
		this.idActividadInsumo = idActividadInsumo;
	}

	public Integer getCantidad() {
		return this.cantidad;
	}

	public void setCantidad(Integer cantidad) {
		this.cantidad = cantidad;
	}

	public Integer getCosto() {
		return this.costo;
	}

	public void setCosto(Integer costo) {
		this.costo = costo;
	}

	public ActividadRealizada getActividadRealizada() {
		return this.actividadRealizada;
	}

	public void setActividadRealizada(ActividadRealizada actividadRealizada) {
		this.actividadRealizada = actividadRealizada;
	}

	public Insumo getInsumo() {
		return this.insumo;
	}

	public void setInsumo(Insumo insumo) {
		this.insumo = insumo;
	}

}