package com.example.ahboard.board.controller;

import com.example.ahboard.board.dto.BoardDTO;
import com.example.ahboard.board.service.BoardService;
import com.example.ahboard.common.dto.PageMaker;
import com.example.ahboard.common.dto.PageRequestDTO;
import com.example.ahboard.common.dto.PageResponseDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/board/*")
@Log4j2
@RequiredArgsConstructor
public class BoardController {

    private final BoardService boardService;

    @GetMapping("/register")
    public void registerGet() {

    }

    @PostMapping("/register")
    public String registerPost(BoardDTO boardDTO, RedirectAttributes redirectAttributes){

        log.info("boardDTOM           " + boardDTO);

        Long bno = boardService.register(boardDTO);

        log.info("==================c     registerPost===================");
        log.info(bno);
        redirectAttributes.addFlashAttribute("result", bno);

        return "redirect:/board/list";
    }

    @GetMapping("/list")
    public void getList(PageRequestDTO pageRequestDTO, Model model) {

        log.warn("c    getList................" + pageRequestDTO);

        log.warn("====================================");
        log.warn(boardService);
        log.warn("====================================");

        PageResponseDTO<BoardDTO> responseDTO = boardService.getDTOList(pageRequestDTO);

        model.addAttribute("dtoList", responseDTO.getDtoList());

        int total = responseDTO.getCount();
        int page = pageRequestDTO.getPage();
        int size = pageRequestDTO.getSize();

        model.addAttribute("pageMaker", new PageMaker(page, size, total));

    }

    @GetMapping(value = {"/read", "/modify"})
    public void read(Long bno, PageRequestDTO pageResponseDTO, Model model) {

        log.warn("c     read " + bno);
        log.warn("c     read " + pageResponseDTO);

        model.addAttribute("boardDTO", boardService.read(bno));

    }

    @PostMapping("/remove")
    public String remove(Long bno, RedirectAttributes redirectAttributes) {

        log.info("c     remove: " + bno);

        if(boardService.remove(bno)) {
            log.info(bno);
            redirectAttributes.addFlashAttribute("result", "success");
        }
        return "redirect:/board/list";
    }

    @PostMapping("/modify")
    public String modify(BoardDTO boardDTO, PageRequestDTO pageRequestDTO, RedirectAttributes redirectAttributes) {

        log.info("--------------------modify-------------");
        log.info("--------------------modify-------------");
        log.info("--------------------modify-------------");

        log.info("c        modify: " + boardDTO);

        log.info("--------------------modify-------------");
        log.info("--------------------modify-------------");
        log.info("--------------------modify-------------");

        if(boardService.modify(boardDTO)) {
            redirectAttributes.addFlashAttribute("result", "modified"); //flash 하면 눈에 안보임
        }
        redirectAttributes.addAttribute("bno", boardDTO.getBno()); //bno 값을 가져와줌
        redirectAttributes.addAttribute("page", pageRequestDTO.getPage());
        redirectAttributes.addAttribute("size", pageRequestDTO.getSize());

        if(pageRequestDTO.getType() != null) {
            redirectAttributes.addAttribute("type", pageRequestDTO.getType());
            redirectAttributes.addAttribute("keyword", pageRequestDTO.getKeyword());
        }

        return "redirect:/board/read";
    }

}
