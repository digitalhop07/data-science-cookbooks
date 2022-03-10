FROM gcr.io/sp-science-box/science-box-image:1.0.1
MAINTAINER Science Box Maintainers <science-box@spotify.com>

# Install additional python packages.
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

# Install additional R packages.
COPY packages.R /tmp/packages.R
RUN Rscript /tmp/packages.R
