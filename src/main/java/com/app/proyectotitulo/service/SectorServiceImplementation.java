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
	
	public Integer  TotalSuperficieSector(int id_sector) {
		// TODO Auto-generated method stub
		return sectorRepo.TotalSuperSector( id_sector);
	}
	

}
