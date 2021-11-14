package com.example.ahboard.board.service;

import com.example.ahboard.board.dto.BoardDTO;
import com.example.ahboard.common.dto.PageRequestDTO;
import com.example.ahboard.common.dto.PageResponseDTO;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface BoardService {

    Long register(BoardDTO boardDTO);

    PageResponseDTO<BoardDTO> getDTOList(PageRequestDTO pageRequestDTO);

    BoardDTO read(Long bno);

    boolean remove(Long bno);

    boolean modify(BoardDTO boardDTO);

}
