package com.app.proyectotitulo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.proyectotitulo.repository.InsumoRepository;

@Service
public class InsumoServiceImplementation implements InsumoService {

	private InsumoRepository insumoRepo;

	@Autowired
	public void setInsumoRepository(InsumoRepository insumoRepository) {
		insumoRepo = insumoRepository;
	}

}
