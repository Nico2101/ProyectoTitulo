package com.app.proyectotitulo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.proyectotitulo.domain.Insumo;
import com.app.proyectotitulo.domain.Sector;
import com.app.proyectotitulo.repository.SectorRepository;

@Service
public class SectorServiceImplementation implements SectorService {

	private SectorRepository sectorRepo;

	@Autowired
	public void setSectorRepository(SectorRepository sectorRepository) {
		sectorRepo = sectorRepository;
	}

	@Override
	public List<Sector> listarSectores(boolean sectorEliminado) {
		// TODO Auto-generated method stub
		return sectorRepo.findBySectorEliminadoOrderByNombreAsc(sectorEliminado);
	}

	@Override
	public Sector saveAndFlush(Sector s) {
		// TODO Auto-generated method stub
		return sectorRepo.saveAndFlush(s);

	}

	@Override
	public Sector findByIdSector(int idSector) {
		// TODO Auto-generated method stub
		return sectorRepo.findByIdSector(idSector);
	}

	@Override
	public Sector eliminarSector(Sector s) {
		// TODO Auto-generated method stub
		return sectorRepo.save(s);
	}

	@Override
	public Sector editarSector(Sector s) {
		// TODO Auto-generated method stub
		return sectorRepo.save(s);
	}

	public Integer TotalSuperficieSector(int id_sector) {
		// TODO Auto-generated method stub
		return sectorRepo.TotalSuperSector(id_sector);
	}

	@Override
	public List<Sector> listaSectoresConPrediosConPlanes(int id_temporada) {
		// TODO Auto-generated method stub
		return sectorRepo.listaSectoresConPrediosConPlanAsignado(id_temporada);
	}

	@Override
	public List<Sector> listaSectoresParaCostos(int id_temporada) {
		// TODO Auto-generated method stub
		return sectorRepo.listaDeSectoresParaCostos(id_temporada);
	}

	
	@Override
	public Sector findByNombre(String nombre) {
		// TODO Auto-generated method stub
		return sectorRepo.findByNombre(nombre);
	}
}
