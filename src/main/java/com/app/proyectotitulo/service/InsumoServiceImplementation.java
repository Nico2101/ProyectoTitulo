package com.app.proyectotitulo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.proyectotitulo.domain.Insumo;
import com.app.proyectotitulo.repository.InsumoRepository;

@Service
public class InsumoServiceImplementation implements InsumoService {

	private InsumoRepository insumoRepo;

	@Autowired
	public void setInsumoRepository(InsumoRepository insumoRepository) {
		insumoRepo = insumoRepository;
	}

	@Override
	public List<Insumo> listarTodosLosInsumos(boolean insumoEliminado) {
		// TODO Auto-generated method stub
		return insumoRepo.findByInsumoEliminado(insumoEliminado);
	}

	@Override
	public Insumo saveAndFlush(Insumo i) {
		// TODO Auto-generated method stub
		return insumoRepo.saveAndFlush(i);
	}

}
