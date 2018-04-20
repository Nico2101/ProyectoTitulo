package com.app.proyectotitulo.domain;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the predio database table.
 * 
 */
@Entity
@NamedQuery(name="Predio.findAll", query="SELECT p FROM Predio p")
public class Predio implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="id_predio")
	private int idPredio;

	private String nombre;

	private int superficie;

	//bi-directional many-to-one association to ActividadRealizada
	@OneToMany(mappedBy="predio")
	private List<ActividadRealizada> actividadRealizadas;

	//bi-directional many-to-one association to Sector
	@ManyToOne
	@JoinColumn(name="id_sector")
	private Sector sector;

	public Predio() {
	}

	public int getIdPredio() {
		return this.idPredio;
	}

	public void setIdPredio(int idPredio) {
		this.idPredio = idPredio;
	}

	public String getNombre() {
		return this.nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public int getSuperficie() {
		return this.superficie;
	}

	public void setSuperficie(int superficie) {
		this.superficie = superficie;
	}

	public List<ActividadRealizada> getActividadRealizadas() {
		return this.actividadRealizadas;
	}

	public void setActividadRealizadas(List<ActividadRealizada> actividadRealizadas) {
		this.actividadRealizadas = actividadRealizadas;
	}

	public ActividadRealizada addActividadRealizada(ActividadRealizada actividadRealizada) {
		getActividadRealizadas().add(actividadRealizada);
		actividadRealizada.setPredio(this);

		return actividadRealizada;
	}

	public ActividadRealizada removeActividadRealizada(ActividadRealizada actividadRealizada) {
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