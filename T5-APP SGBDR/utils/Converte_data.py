def formata_datas(string: str) -> str:
    """
    Função que formata as datas de cada dataframe que estão no formato
    DD/MM/YYYY 00:00:00 para YYYY-MM-DD.
    Caso tenha horário junto com as datas, ele será descartado.
    """
    string = string.split(" ")[0] if ":" in string else string
    if "-" in string:
        return string
    else:
        data = string.split("/")
        dia = data[0]
        mes = data[1]
        ano = data[2]
        return ano + "-" + mes + "-" + dia
