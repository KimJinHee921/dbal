package com.dbal.dto;

import java.util.ArrayList;
import java.util.List;

public class BoardListDTO {
	private BoardDTO board;
	List<ListDTO> boardList;

	public BoardListDTO() {}

	public BoardListDTO(BoardDTO board) {
		this.board = board;
		boardList = new ArrayList<ListDTO>();
	}

	public BoardDTO getBoard() {
		return board;
	}

	public List<ListDTO> getBoardList() {
		return boardList;
	}

	public void setBoard(BoardDTO board) {
		this.board = board;
	}

	public void setBoardList(List<ListDTO> boardList) {
		this.boardList = boardList;
	}
}
