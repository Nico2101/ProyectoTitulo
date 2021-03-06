package com.app.proyectotitulo.domain;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonBackReference;

import java.util.List;

/**
 * The persistent class for the Insumo database table.
 * 
 */
@Entity
@NamedQuery(name = "Insumo.findAll", query = "SELECT i FROM Insumo i")
public class Insumo implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id_insumo")
	private int idInsumo;

	@Column(name = "insumo_eliminado")
	private boolean insumoEliminado;

	private String marca;

	private String nombre;

	private String tipo;

	@Column(name = "unidad_medida")
	private String unidadMedida;

	// bi-directional many-to-one association to Actividad_Insumo
	@OneToMany(mappedBy = "insumo")
	@JsonBackReference
	private List<Actividad_Insumo> actividadInsumos;

	public Insumo() {
	}

	public int getIdInsumo() {
		return this.idInsumo;
	}

	public void setIdInsumo(int idInsumo) {
		this.idInsumo = idInsumo;
	}

	public boolean getInsumoEliminado() {
		return this.insumoEliminado;
	}

	public void setInsumoEliminado(boolean insumoEliminado) {
		this.insumoEliminado = insumoEliminado;
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

	public List<Actividad_Insumo> getActividadInsumos() {
		return this.actividadInsumos;
	}

	public void setActividadInsumos(List<Actividad_Insumo> actividadInsumos) {
		this.actividadInsumos = actividadInsumos;
	}

	public Actividad_Insumo addActividadInsumo(Actividad_Insumo actividadInsumo) {
		getActividadInsumos().add(actividadInsumo);
		actividadInsumo.setInsumo(this);

		return actividadInsumo;
	}

	public Actividad_Insumo removeActividadInsumo(Actividad_Insumo actividadInsumo) {
		getActividadInsumos().remove(actividadInsumo);
		actividadInsumo.setInsumo(null);

		return actividadInsumo;
	}

}