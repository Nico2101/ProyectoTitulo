package com.app.proyectotitulo.domain;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the insumo database table.
 * 
 */
@Entity
@NamedQuery(name="Insumo.findAll", query="SELECT i FROM Insumo i")
public class Insumo implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="id_insumo")
	private int idInsumo;

	private String marca;

	private String nombre;

	private String tipo;

	@Column(name="unidad_medida")
	private String unidadMedida;

	//bi-directional many-to-one association to ActividadInsumo
	@OneToMany(mappedBy="insumo")
	private List<ActividadInsumo> actividadInsumos;

	public Insumo() {
	}

	public int getIdInsumo() {
		return this.idInsumo;
	}

	public void setIdInsumo(int idInsumo) {
		this.idInsumo = idInsumo;
	}

	public String getMarca() {
		return this.marca;
	}

	public void setMarca(String marca) {
		this.marca = marca;
	}

	public String getNombre() {
		return this.nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getTipo() {
		return this.tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public String getUnidadMedida() {
		return this.unidadMedida;
	}

	public void setUnidadMedida(String unidadMedida) {
		this.unidadMedida = unidadMedida;
	}

	public List<ActividadInsumo> getActividadInsumos() {
		return this.actividadInsumos;
	}

	public void setActividadInsumos(List<ActividadInsumo> actividadInsumos) {
		this.actividadInsumos = actividadInsumos;
	}

	public ActividadInsumo addActividadInsumo(ActividadInsumo actividadInsumo) {
		getActividadInsumos().add(actividadInsumo);
		actividadInsumo.setInsumo(this);

		return actividadInsumo;
	}

	public ActividadInsumo removeActividadInsumo(ActividadInsumo actividadInsumo) {
		getActividadInsumos().remove(actividadInsumo);
		actividadInsumo.setInsumo(null);

		return actividadInsumo;
	}

}