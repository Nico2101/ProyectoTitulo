package com.app.proyectotitulo.domain;

import java.io.Serializable;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonBackReference;

import java.util.List;

/**
 * The persistent class for the Sector database table.
 * 
 */
@Entity
@NamedQuery(name = "Sector.findAll", query = "SELECT s FROM Sector s")
public class Sector implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id_sector")
	private int idSector;

	private String nombre;

	@Column(name = "sector_eliminado")
	private boolean sectorEliminado;

	private Integer superficie;

	// bi-directional many-to-one association to Predio
	@OneToMany(mappedBy = "sector")
	@JsonBackReference
	private List<Predio> predios;

	public Sector() {
	}

	public int getIdSector() {
		return this.idSector;
	}

	public void setIdSector(int idSector) {
		this.idSector = idSector;
	}

	public String getNombre() {
		return this.nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public boolean getSectorEliminado() {
		return this.sectorEliminado;
	}

	public void setSectorEliminado(boolean sectorEliminado) {
		this.sectorEliminado = sectorEliminado;
	}

	public Integer getSuperficie() {
		return this.superficie;
	}

	public void setSuperficie(Integer superficie) {
		this.superficie = superficie;
	}

	public List<Predio> getPredios() {
		return this.predios;
	}

	public void setPredios(List<Predio> predios) {
		this.predios = predios;
	}

	public Predio addPredio(Predio predio) {
		getPredios().add(predio);
		predio.setSector(this);

		return predio;
	}

	public Predio removePredio(Predio predio) {
		getPredios().remove(predio);
		predio.setSector(null);

		return predio;
	}

}